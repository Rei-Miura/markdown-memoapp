# markdown-memoapp
Markdown形式の入力に対応したメモアプリです。  
MarkdownからHTMLへの変換には[markdown-parser-go](https://github.com/Rei-Miura/markdown-parser-go/tree/main)を使用しました。

## 使用例
https://github.com/user-attachments/assets/fb83960c-ca69-4caf-86e4-7faed8fe332e

## 使用技術
- Go 1.20
- Node.js 18.15.0
- Vue 3

## 使用方法
### 1. Dockerコンテナの起動  
以下のコマンドを実行すると、Dockerイメージ作成後にコンテナが起動します。  
```bash
make init
```

### 2. バックエンドサーバーを起動する  
以下のコマンドを実行すると、バックエンドサーバーが起動します。  
```bash
make back-serve
```

### 3. フロントエンドサーバーを起動する  
以下のコマンドを実行すると、フロントエンドサーバーが起動します。  
```bash
make front-serve
```

### 4. アプリケーションにアクセスする  
以下のURLからアプリケーションにアクセスできます。  
[http://localhost:3000](http://localhost:3000)  

## 終了方法  
### Dockerコンテナの停止と削除    
以下のコマンドを実行すると、Dockerコンテナが停止し、削除されます。  
```bash
make down
```
