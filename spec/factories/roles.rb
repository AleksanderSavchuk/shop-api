# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    trait :admin do
      name { 'admin' }
    end

    trait :client do
      name { 'client' }
    end
  end
end
