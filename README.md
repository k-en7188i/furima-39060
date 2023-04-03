# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions




# フリマアプリ データベース設計

## users テーブル（会員情報）

| Column          | Type    | Options                   |
| --------------- | ------- | ------------------------- |
| id              | integer | primary key               |
| nickname        | string  | null: false               |
| email           | string  | null: false, unique: true |
| password        | string  | null: false               |
| first_name      | string  | null: false               |
| last_name       | string  | null: false               |
| first_name_kana | string  | null: false               |
| last_name_kana  | string  | null: false               |
| birth_date      | date    | null: false               |

### Association
- has_many :items
- has_many :purchases


## items テーブル（商品情報）

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| id            | integer    | primary key                    |
| user_id       | references | null: false, foreign_key: true |
| name          | string     | null: false                    |
| description   | text       | null: false                    |
| category      | string     | null: false                    |
| condition     | string     | null: false                    |
| shipping_fee  | string     | null: false                    |
| region        | string     | null: false                    |
| shipping_days | string     | null: false                    |
| price         | integer    | null: false                    |
| sale_fee      | integer    | null: false                    |
| profit        | integer    | null: false                    |

### Association
- belongs_to :user
- has_one :purchases
- has_one_attached :image(Active Storage)


## purchases テーブル（商品購入情報）

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| id            | integer    | primary key                    |
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |
| postal_code   | string     | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |

### Association
- belongs_to :user
- belongs_to :item
