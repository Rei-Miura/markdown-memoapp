# ベースイメージの指定
FROM golang:1.20

# 作業ディレクトリの設定
WORKDIR /app

# Go の依存関係をコピーしてインストール
COPY backend/go.mod backend/go.sum backend/main.go ./
RUN go mod download