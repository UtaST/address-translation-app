FactoryBot.define do
  factory :address do
    postal_code {"333-0003"}
    prefecture {"テスト県"}
    city {"テスト市テスト区"}
    house_number {"試験1-1-1"}
    building_name {"テストビル111"}

    association :user
  end
end
