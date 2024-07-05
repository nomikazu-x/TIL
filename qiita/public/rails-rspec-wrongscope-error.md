---
title: Rspec WrongScopeError発生
tags:
  - Ruby
  - Rails
  - RSpec
private: false
updated_at: '2024-07-05T20:01:31+09:00'
id: 8517d3b7eb8889fa8ff5
organization_url_name: null
slide: false
ignorePublish: false
---

Rspecでテストを走らせた際に発生した問題について、備忘録として投稿します。

## 発生した問題

```
Failure/Error:
       raise WrongScopeError,
             "`#{name}` is not available from within an example (e.g. an " \
             "`it` block) or from constructs that run in the scope of an " \
             "example (e.g. `before`, `let`, etc). It is only available " \
             "on an example group (e.g. a `describe` or `context` block)."

       `name` is not available from within an example (e.g. an `it` block) or from constructs that run in the scope of an example (e.g. `before`, `let`, etc). It is only available on an example group (e.g. a `describe` or `context` block)
```

nameに心当たりがないので、Rspecの設定に問題があると推測。

## 原因

https://github.com/rspec/rspec-rails/issues/2417

rspec-rails3.xだとバージョンが低いことが理由のようです。

## 対策

```Gemfile
gem "rspec-rails", "~> 4.0.2"
```

この設定で無事、テストが走りました！

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる限定の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://bit.ly/3xLrLGw
