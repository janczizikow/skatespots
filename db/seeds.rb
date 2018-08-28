# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'pry-byebug'
require 'geocoder'

##################################################################
# GENERATE CATEGORIES
unless Category.all.present?
  puts 'Generating categories...'
  file = Rails.root.join('db', 'categories.yml')
  data = YAML.safe_load(File.read(file))
  data['categories'].each { |category| Category.create!(name: category) }
end
##################################################################

user = nil
if User.find_by(email: 'john.doe@gmail.com').present?
  user = User.find_by(email: 'john.doe@gmail.com')
else
  user = User.create!(email: 'scrapper-bot@gmail.com', password: "#{ENV['BOT_PASSWORD']}", remote_avatar_url: 'https://cdn.iconscout.com/icon/premium/png-512-thumb/angry-bot-1-701002.png')
end

CATEGORIES = Category.pluck(:name)

def scrapper(url)
  puts "Generating spot for #{url}..."
  parse_url = URI.parse(url).open
  html_doc = Nokogiri::HTML(parse_url)

  title = html_doc.css('h1.job_listing-title').text.strip
  address = html_doc.css('.google_map_link').first.children.reduce("") { |acc, cur| acc + " " + cur.text }.gsub("  ", " ").strip
  description = html_doc.css('.widget-title.widget-title-job_listing.ion-ios-paper-outline').first.parent.children[1].text.strip
  photo = html_doc.css('.content-single-job_listing-hero').attribute('style').value[/\(.*?\)/].gsub(/\(|\)/, "")
  categories = html_doc.css('.job_listing_tag-list').children.map {|el| el.text}.select {|el| CATEGORIES.include?(el)}
  params = {
    name: title,
    address: address,
    description: description,
    # spots_photos_attributes: {
    #   "0": {
    #     user_id: User.find_by(email: 'john.doe@gmail.com').id,
    #     remote_photo_url: photo
    #   }
    # }
    photo: photo,
    categories: categories.map{ |category| Category.find_by(name: category).id }
  }
  # binding.pry
end

# scrapper('https://myskatespots.com/listing/fjerritslev-skatepark/')

links_data = File.join(__dir__, "sample_data", "spots.yml")

puts 'Generating spots...'
urls = YAML.safe_load(File.read(links_data))
urls.take(50).each do |url|
  params = scrapper(url)
  puts "Geocoding..."
  result = Geocoder.search(params[:address])
  city_name = result.first.city
  address = result.first.address.gsub(result.first.country, "").gsub(", ", "")
  city = CreateCity.new(city: city_name).call
  if city.success?
    puts "Generating spot..."
    spot = Spot.create!(params.except(:photo, :categories).merge(user_id: user.id, city_id: city.data.id))
    puts "Generated spot #{spot.name.upcase}!"
    if params[:photo].present?
      puts "Uploading picture from #{params[:photo]}..."
      spots_photo = SpotsPhoto.create!(spot_id: spot.id, remote_photo_url: params[:photo], user_id: user.id)
    else
      puts "No photo found!"
    end
    if params[:categories].present?
      puts "Adding categories to #{spot.name.upcase}..."
      params[:categories].each do |category|
        SpotsCategory.create!(category_id: category, spot_id: spot.id)
      end
    else
      puts "No categories found"
    end
  else
    puts "WRONG CITY, SKIPPING TO NEXT ITEM"
    next
  end
end

