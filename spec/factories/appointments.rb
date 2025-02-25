FactoryBot.define do
  factory :appointment do
    scheduled_at { Time.zone.now + 1.day }
    duration { 30 }
    status { 'pending' }
    association :user
    association :client
    association :location
  end
end
