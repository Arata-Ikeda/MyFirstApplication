# ベースとなるRubyイメージを指定
ARG RUBY_VERSION=3.4.4
FROM ruby:$RUBY_VERSION

# 必要なOSパッケージ、Node.js、Yarnを一度にインストール
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update -qq && \
    apt-get install -y build-essential git curl sqlite3 nodejs libvips-dev && \
    npm install -g yarn

# 作業ディレクトリを設定
WORKDIR /rails

# --- ここからが最終修正版の戦略 ---

# 1. package.jsonをコピー
COPY package.json ./

# 2. yarn installを実行
# これがnode_modulesとyarn.lockをイメージ内に正しく生成する
RUN yarn install

# 3. Gemfileをコピー
COPY Gemfile* ./

# 4. bundle installを実行
RUN bundle install

# 5. 最後にアプリケーションの全コードをコピー
COPY . .

# --- ここまで ---

# ポートを公開し、デフォルトの起動コマンドを設定
EXPOSE 3000
CMD ["./bin/dev"]