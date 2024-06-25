---
title: rails sが起動しなくなった
tags:
  - Ruby
  - Rails
  - puma
private: false
updated_at: '2024-06-25T23:51:14+09:00'
id: 4e8fdab4ef696421adf5
organization_url_name: null
slide: false
ignorePublish: false
---

`rails s`が動かない現象に遭遇したので、備忘録として投稿します。

## 発生した問題

下記エラーにより、`rails s`が起動しなくなった。

```
% rails s
=> Booting Puma
=> Rails 6.1.5 application starting in development 
=> Run `bin/rails server --help` for more startup options
Exiting
bin/rails:7: warning: already initialized constant APP_PATH
/Users/xxxx/workspace/app/bin/rails:7: warning: previous definition of APP_PATH was here
The most common rails commands are:
 generate     Generate new code (short-cut alias: "g")
 console      Start the Rails console (short-cut alias: "c")
 server       Start the Rails server (short-cut alias: "s")
 test         Run tests except system tests (short-cut alias: "t")
 test:system  Run system tests
 dbconsole    Start a console for the database specified in config/database.yml
              (short-cut alias: "db")

 new          Create a new Rails application. "rails new my_app" creates a
              new application called MyApp in "./my_app"

All commands can be run with -h (or --help) for more information.
In addition to those commands, there are:

  about
  action_mailbox:ingress:exim
  action_mailbox:ingress:postfix
〜省略〜
  webpacker:yarn_install
  yarn:install
  zeitwerk:check
```

## 原因

原因は、

```
% bundle config set --local without 'test development'
```

上記コマンドにより、設定が残ってしまうというものです。

```
% bundle install --without test development
```

上記だと設定が残らない。

## 確認

```
% bundle config
Settings are listed in order of priority. The top value will be used.
–delete
Set for the current user (/Users/xxxx/.bundle/config): "without"

without
Set for your local app (/Users/xxxx/workspace/app/.bundle/config): [:test, :development]
```
`–without test development`が設定されている。

## 解除
```
% bundle config --delete without
```
## 再確認
```
% bundle config                 
Settings are listed in order of priority. The top value will be used.
–delete
Set for the current user (/Users/xxxx/.bundle/config): "without"
```
`–without`が無くなり、`rails s`も動くようになりました！
