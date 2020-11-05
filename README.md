# テーブル設計

## users テーブル

| colum          | type    | option      |
| -------------- | ------- | ----------- |
| email          | string  | null: false |
| password       | string  | null: false |
| nickname       | string  | null: false |
| birthday       | date    |             |
| gender_id      | integer |             |
| introduction   | text    |             |
| job            | string  |             |
| hobby          | text    |             |
| prefectures_id | integer |             |


### Association
- has_many :posts
- has_one_attached :image
- has_many :rooms, through: :room_users
- has_many :room_users
- has_many :messages

### その他
gender_id :active_hash
birthday :date_select
gem :devise
- gem: 'mini_magick' でimageを実装



## posts テーブル

| colum          | type       | option                         |
| -------------- | ---------- | ------------------------------ |
| title          | string     | null: false                    |
| category_id    | integer    | null: false                    |
| description    | text       | null: false                    |
| day_time       | date       |                                |
| prefectures_id | integer    |                                |
| place          | text       |                                |
| budget         | text       |                                |
| user           | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :room

### その他
prefectures_id :active_hash
category_id :active_hash
- gem: 'mini_magick' でimageを実装

カテゴリーはタグで付けたい



## rooms テーブル

| colum | type       | option                         |
| ----- | ---------- | ------------------------------ |
| post  | references | null: false, foreign_key: true |

### Association
- belongs_to :post
- has_many :users, through: :room_users
- has_many :room_users
- has_many :messages


## room_users テーブル

| colum   | type       | option                         |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| room_id | references | null: false, foreign_key: true |

### Association
- belongs_to :room
- belongs_to :user


## messages テーブル

| colum | type       | option                         |
| ----- | ---------- | ------------------------------ |
| text  | text       | null: false                    |
| user  | references | null: false, foreign_key: true |
| room  | references | null: false, foreign_key: true |


### Association
- belongs_to :room
- belongs_to :user

### その他
- gem: 'mini_magick' でimageを実装