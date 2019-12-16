# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { FFaker::Name.unique.first_name }
    description { FFaker::Music.album }
  end
end
