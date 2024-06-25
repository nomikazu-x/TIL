---
title: RailsのHostAuthorizationによってELBのヘルスチェックがhealthyにならない
tags:
  - Ruby
  - Rails
  - AWS
  - elb
private: false
updated_at: '2024-06-25T23:39:22+09:00'
id: 6eae4ac6e5ffb886fb08
organization_url_name: null
slide: false
ignorePublish: false
---

ポートフォリオをデプロイする際に発生した問題について、備忘録として投稿します。

## 発生した問題

Rails6 + AWSで下記の構成のようなアプリを開発していました。

Railsの`HostAuthorization`を利用し、`/api/health_check`というパスでALBからのヘルスチェックを行おうとしました。
しかし、Railsが403エラーを返し、ヘルスチェックが失敗してしまいました。

## 原因

Railsの設定は下記のようになっていました。
![](https://raw.githubusercontent.com/nomikazu-x/post-zenn-qiita/master/images/prettier-plugin-astro-organize-imports/alb-esc-nginx-rails-rds.jpg)

```ruby:environments/production.rb
config.hosts << 'base_domain.com'
```

原因は、
「ヘルスチェック時のホスト名がbase_domain.comでないからエラーになっていた」
というものです。

## 対策
```ruby:environments/production.rb
config.hosts << "base_domain.com"
config.host_authorization = { 
  exclude: -> (request) { request.path == '/api/health_check' }
}
```

この設定で無事、ALBからのhealthcheckでhealthyになりました！

## 参考
- [Rails6 で LoadBalancer からのヘルスチェックが 403 にならないようにする](https://qiita.com/takahiro-nakayama/items/33333333333333333333)
- [Railsガイド 3.4 ミドルウェアを設定する](https://railsguides.jp/configuring.html#configuring-middleware)
