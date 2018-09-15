FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    age { rand(0..100) }
    gender { rand(0..1) }
    latitude { rand(-90.0..90.0) }
    longitude { rand(-90.0..90.0) }
  end
end
