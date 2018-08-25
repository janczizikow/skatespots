# frozen_string_literal: true

FactoryBot.define do
  factory :favorite do
    user nil
    spot nil
  end

  factory :review do
    rating 1
    content 'MyText'
    user nil
    spot nil
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :city do
    name { 'Warsaw' }
  end
end
