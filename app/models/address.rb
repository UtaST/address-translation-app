class Address < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{7}\z/, message: "を正しく入力してください"}
    validates :prefecture
    validates :city
    validates :town_name
    validates :house_number
  end
end
