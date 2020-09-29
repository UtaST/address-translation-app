class Address < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{7}\z/, message: "を正しく入力してください"}
    validates :city
    validates :house_number
  end

  validates :prefecture_code, numericality: { other_than: 0, message: "を選択してください" }
end
