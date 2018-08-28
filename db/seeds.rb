# frozen_string_literal: true

require 'yaml'

file = Rails.root.join('db', 'categories.yml')
data = YAML.safe_load(File.read(file))

data['categories'].each { |category| Category.create! category }
