# address-translation-app（住所英訳アプリ）

## アプリ概要

入力した住所を英語（ローマ字）表記に変換し、各項目ごとにワンクリックでコピーすることができます。また、ユーザー登録を行うことで登録した住所の英訳を素早く取得することができます。

## 本番環境

### URL

http://54.95.243.100/

### テストアカウント

**Eメール**：check1@com
**パスワード**：check1

## 制作背景

AWSなど海外のサイトに住所を登録する際、翻訳の仕方や書き順などが複雑で大変に感じました。そのため住所を英語表記に変換し、各項目ごとにコピーできるアプリケーションを開発しました。

## 利用方法

以下のgif画像を参考にご利用ください。
[![Image from Gyazo](https://i.gyazo.com/d1a20d3adc36b7b6aa99f55949e91ba9.gif)](https://gyazo.com/d1a20d3adc36b7b6aa99f55949e91ba9)

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