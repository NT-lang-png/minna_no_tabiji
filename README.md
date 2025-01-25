# みんなの旅路

## サイト概要
おすすめの旅の旅程表を投稿できるSNSサービスです。<br>
旅程表を、位置情報付きでご確認いただけます。

![Image](https://github.com/user-attachments/assets/f30ae373-72b9-4191-8586-890e45eeea99)


- ### URL
https://minna-no-tabiji.com/ <br>
画面真ん中、もしくはヘッダーののゲストログインボタンから、メールアドレスとパスワードを入力せずにログインできます。

- ### テーマを選んだ理由

私は、旅行に行く際に、必ず旅程表を作成しております。また、自身が旅程表を作る際には、地図に手書きでマークをしているため、地図も一緒になった旅程表が作れる旅のしおりアプリがあれば便利だと感じました。
また、旅行好きな人が、おすすめの旅程表を紹介し合えたらさらに旅行が楽しくなると思い、このテーマにしました。

- ### ターゲットユーザ

  - 旅行が好きで、旅程を組むのが好きな人。
  - おすすめの旅程を知りたい人。
  - 旅のしおりを思い出として残しておきたい人。
  - 旅の行先の地理感を把握しておきたい人。

- ### 主な利用シーン

  - 旅行に行く前に綿密にプランを立てたい時。
  - 旅行中に次にどこに行くか確認したい時。
  - 自身のおすすめ旅行プランを紹介したい時。
  - 誰かの旅行プランを参考にしたい時。

## 設計書
- [ER図・UIフロー図はこちら](https://app.diagrams.net/#G1-YS-6yFkuxo5he79xrudsHJI9GZVH0rU#%7B%22pageId%22%3A%22-yT91W0jGG4PveUTrms9%22%7D)
- [アプリケーション詳細設計書はこちら](https://docs.google.com/spreadsheets/d/17Q9Fz1kNpNv5muBtrOj0HQ6NsExVsC66fTzZZlE0Vao/edit?gid=549108681#gid=549108681)
- [テーブル定義書はこちら](https://docs.google.com/spreadsheets/d/1ccuTQBmAbBUtC1A0iU8rwdNNuAHLwu6gyJ1eA8egO_U/edit?gid=1185360574#gid=1185360574)

## デザイン設計書
- [ワイヤーフレームはこちら](https://drive.google.com/drive/u/0/folders/1kxbK5zYJV_fjiNzLyECHX6o2nWog18-H)
- [デザイン案はこちら](https://drive.google.com/drive/u/0/folders/1kxbK5zYJV_fjiNzLyECHX6o2nWog18-H)

## AWS構成図
<img src="https://github.com/user-attachments/assets/d7d7ccbc-0cbe-4f8c-bccf-c9d1bd263dfc" alt="Image" width="400">

## 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能
  - 画像投稿
  - 位置情報表示機能(geocoder)
  - 公開・非公開・下書き機能
- ブックマーク機能(Ajax)
- コメント機能(Ajax)
- フォロー機能
- ページネーション機能(kaminari)
- 検索機能

## 開発環境
- Ruby 3.1.2
- Ruby on Rails 6.1.7.10
- MySQL 8.0.35
- Nginx
- Puma
- AWS
  - VPC
  - EC2
  - RDS
  - Route53
- Google Maps API

## 使用素材
- フォント: google Fonts（Roboto）

## データについて
- このアプリでは、旅のしおり作成のために実在する地名や観光名所（例: 東京タワー、大阪城など）を利用しています。
- データは一般公開されている情報を基にしていますが、著作権や商標権に関わる素材（例: 画像やロゴなど）を利用する場合は、事前に著作権保持者と契約を結ぶか、許諾を得た上で使用します。
