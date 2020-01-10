# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.first_name }
    username { FFaker::Name.unique.last_name }
    email { FFaker::Internet.email }
    password { 'blessings' }

    trait :admin do
      roles { [Role.find_by(name: 'admin') || create(:role, :admin)] }
    end

    trait :client do
      roles { [Role.find_by(name: 'client') || create(:role, :client)] }
    end
  end
end
