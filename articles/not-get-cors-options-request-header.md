---
title: CORS設定でOPTIONSリクエストとヘッダが取得できない
emoji: 📝
type: tech
topics:
  - Ruby
  - Rails
  - CORS
  - Nuxt
  - Vue
published: true
---

実装中に対応した内容を備忘録として投稿します。

## 発生した問題

フロントエンド(Nuxt.js)から、バックエンド(Rails)に対して、APIリクエストを投げるとCORSエラーが発生。
```
Access to XMLHttpRequest at 'http://localhost:3000/users/1' from origin 'http://localhost:8080' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
```
## 原因

- ブラウザ側のセキュリティが強化されていて、意図しない挙動を防ぐために実装されている。
- もし仮に、ハッキングされるなどすると、
  - フロントエンドとバックエンドでサーバーやドメインが別れている場合に、悪意のあるドメインにすり替えるなどができてしまう。
  - 会員制サイトでログインするときに、ログインIDやパスワードを盗むことができてしまう。
- そのため、意図したドメインやアクションだけを許可する仕組みが標準となっている。

### 補足メモ

- `CORS(Cross-Origin Resource Sharing)`：オリジン間でリソース共有を可能にする仕組み。
- `OPTIONS(preflight)リクエスト`：GET/POST/DELETEリクエストを投げる前の存在チェックしている。
- `Access-Control-Expose-Headers`：ここで許可したレスポンスヘッダしかフロントエンドは取得できない。

## CORS設定（Rails）

- Gemfileに`rack-cors`追加して、bundle installします。
- その後、`config/initializers/cors.rb` を作成します。

```ruby:config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # 公開APIの場合は、*を設定
    resource '*', 
    headers: :any,
    methods: %i[get post patch put delete options head], # 通常使っている「get post patch put delete」以外に、「options head」も設定
    expose: %i[token-type uid client access-token expiry] # 今回はDevise Token Authで使う「uid client access-token expiry」を設定
  end
end
```

以上の設定で、
Nuxt.jsで、undefinedになっていたのが取得できるようになりました。

```
console.log(response.headers['access-token'])
```
