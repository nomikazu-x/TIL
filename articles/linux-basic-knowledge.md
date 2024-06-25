---
title: Rspec WrongScopeErrorが発生
emoji: 📝
type: tech
topics:
  - Ruby
  - Ruby on Rails
  - Rspec
  - テスト
published: true
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

rspec-rails3.xだとバージョンが低いことが理由のようです。

## 対策

```Gemfile
gem "rspec-rails", "~> 4.0.2"
```

この設定で無事、テストが走りました！