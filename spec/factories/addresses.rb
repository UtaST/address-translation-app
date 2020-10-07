FactoryBot.define do
  factory :address do
    postal_code {"3330003"}
    prefecture {"テスト県"}
    city {"テスト市テスト区"}
    town_name {"試験"}
    house_number {"1-1-1"}
    building_name {"テストビル"}
    room_number {"111"}

    association :user
  end
end
