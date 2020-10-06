# テーブル設計

## usersテーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_one :address

## addressesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | integer    | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| town_name     | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| room_number   | string     |                                |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user