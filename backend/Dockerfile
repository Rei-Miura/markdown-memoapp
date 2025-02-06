# ベースイメージを指定
FROM golang:1.20.2

# 作業ディレクトリを設定
WORKDIR /app

# Go モジュールをコピーして依存関係をインストール
COPY go.mod go.sum ./
RUN go mod download

# アプリケーションコードをコピー
COPY . .

# アプリケーションをビルド
RUN go build -o main .

# MySQL が稼働するまで待機
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# アプリケーションを実行
CMD ["/wait-for-it.sh", "mysql:3306", "--", "./main"]
