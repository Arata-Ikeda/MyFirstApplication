# devtraining-rails

このリポジトリは、開発未経験の方にRuby on Railsを使ったバックエンド開発を経験していただくためのテンプレートリポジトリです。

## 事前準備

開発を始める前に、以下のツールやソフトウェアの設定が必要です：

- WSL2の設定 (Windows環境の場合)
- VSCodeのインストール
- Dockerのインストール
- GitHubとのSSH接続の設定

## セットアップ手順

### 1. 作業用リポジトリを作成する

画面上部の「Use this template」ボタンをクリックし、「Create a new repository」を選択します。

必要事項を入力して、自分の作業用リポジトリを作成しましょう。

### 2. リポジトリをクローンする

作成したリポジトリをローカル環境にクローンします。

```bash
$ cd ~
$ git clone git@github.com:${ユーザー名}/${レポジトリ名}.git
$ cd ${レポジトリ名}
```

### 3. Dockerコンテナ内でRailsプロジェクトを作成する

以下のコマンドを実行して、Dockerコンテナ内でRailsプロジェクトを新規作成します。

```bash
$ docker compose run web rails new . --name=${アプリ名} --skip-docker -force
```

### 4. Dockerコンテナをビルドする

```bash
$ docker compose build
```

### 5. Dockerコンテナを起動し、Railsサーバーを立ち上げる

```bash
$ docker compose up -d
```

### 6. Railsの初期画面を確認する

ブラウザで以下のURLにアクセスし、Railsの初期画面が表示されることを確認します。

http://localhost:3000

以上で環境構築は完了です！変更は全てcommitして、リモートリポジトリにpushしておきましょう👍
