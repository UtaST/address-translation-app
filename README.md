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

1. 郵便番号を入力(都道府県・市区町村・町名が自動入力されます)。

2. 残りの項目を入力して翻訳ボタンをクリック(非同期で翻訳され、表示欄に表示されます)。

3. 各表示欄右端のコピーボタンをクリックしてコピー(コピーに成功した場合、メッセージが表示されます)。

## 工夫したポイント

住所の英訳を楽にするためのアプリなので、アプリを使った作業自体も極力少なくなるように
- 郵便番号から住所を自動入力する機能
- ワンクリックで英訳された住所をコピーできる機能

を実装しました。

## 開発環境

Ruby/Ruby on Rails/Javascript/jQuery/MySQL/Github/AWS/Visual Studio Code

## 今後の課題

**ユーザー登録機能を活用する**

複数回英訳した住所を必要とするユーザーがいることを想定してユーザー登録機能を実装しました。しかし現状、何を目的としている機能なのかユーザーに伝わらない状態であり、この機能の意味が薄れてしまっています。今後、簡易的な誘導を設けて本機能が活用されるように追加実装したいと考えています。

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