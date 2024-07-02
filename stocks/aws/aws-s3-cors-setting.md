---
title: S3バケットにCORSポリシーを追加したい
emoji: 🤖
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - AWS
  - S3
  - CORS
  - セキュリティ
published: true
---

Amazon S3バケットを公開ウェブサイトとして設定する場合、他のドメイン上で実行されるJavaScriptからJavaScriptモジュールなどのアセットをロードできるようにCORSをサポートすることができます。

この設定はバケットレベルで行われ、個々のアイテムに適用することはできません。

公式ドキュメントには、JSONドキュメントを手作りする方法が記載されています。その形式に関するドキュメントと便利な例はこちらです。

## s3-credentialsを使う方法

私のs3-credentialsツールには、CORSポリシーを設定するためのコマンドがあります：

```sql
s3-credentials set-cors-policy my-cors-bucket \
  --allowed-method GET \
  --allowed-origin https://simonwillison.net/
```

このコマンドの詳細なドキュメントはこちらにあります。

## S3ウェブコンソールを使う方法
最初に試したのは、S3ウェブコンソールを使う方法です。コンソールインターフェースでバケットを見つけ、「セキュリティ」タブをクリックして、JSON設定を貼り付けることができます。

まず試した設定は以下の通りです：
```json
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET"
        ],
        "AllowedOrigins": [
            "https://simonwillison.net/"
        ],
        "ExposeHeaders": []
    }
]

```

これにより、GETリクエストに対してCORSアクセスが有効になります。

AllowedOriginsキーは興味深いものです。これは、受信リクエストのOriginヘッダーを検査し、そのオリジンがリスト内の値のいずれかと一致する場合にCORSヘッダーを返すことで動作します。

```
~ % curl -i 'http://static.simonwillison.net.s3-website-us-west-1.amazonaws.com/static/2022/photoswipe/photoswipe-lightbox.esm.js' \
  -H "Origin: https://simonwillison.net" | head -n 20
-x-amz-request-id: 4YY7ZBCVJ167XCR9
 Date: Tue, 04 Jan 2022 21:02:44 GMT
-Access-Control-Allow-Origin: *
-Access-Control-Allow-Methods: GET
:Vary: Origin, Access-Control-Request-Headers, Access-Control-Request-Method
-Last-Modified: Tue, 04 Jan 2022 20:10:26 GMT
-ETag: "8e26fa2b966ca8bac30678cdd6af765c"
:Content-Type: text/javascript
-Server: AmazonS3

~ % curl -i 'http://static.simonwillison.net.s3-website-us-west-1.amazonaws.com/static/2022/photoswipe/photoswipe-lightbox.esm.js' | head -n 20
x-amz-request-id: MPD20P9P3X45BR1Q
Date: Tue, 04 Jan 2022 21:02:48 GMT
Last-Modified: Tue, 04 Jan 2022 20:10:26 GMT
ETag: "8e26fa2b966ca8bac30678cdd6af765c"
Content-Type: text/javascript
Server: AmazonS3
```

リクエストにOriginヘッダーが付いている場合、Access-Control-Allow-Originヘッダーが返されます。付いていない場合は返されません。

私のS3バケットはCloudflareキャッシュの背後にあります。上記の通り、S3はVary: Originヘッダーを返し、キャッシュがそのヘッダーを尊重してキャッシュされたコンテンツを返すべきことを示しています。

しかし、Cloudflareは2021年9月にVaryのサポートを追加しましたが、これは画像に対してのみであり、他のファイル形式には対応していません。そのため、Cloudflareを使用している場合、この方法でJavaScriptモジュールにCORSを使用することはできないと思います。

また、S3設定で"AllowedOrigins": ["*"]を試しましたが、Originヘッダーなしでリクエストを行うと、S3は依然としてAccess-Control-Allow-Originを返しません。そのため、Varyをサポートしないキャッシュの下では、これらのヘッダーなしでアセットがキャッシュされるリスクがあります。

