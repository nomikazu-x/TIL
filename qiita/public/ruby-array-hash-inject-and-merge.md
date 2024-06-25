---
title: Rubyで配列内のハッシュで同じキーの値を合算(inject、merge)
private: false
tags:
  - Ruby
  - Rails
updated_at: '2024-06-25T15:06:06.100Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

ポートフォリオ作成中に、「同一のキーを合算して、値を求める」必要があり、実装に時間を要したため、備忘録として投稿します。

## 実現したいこと

```ruby 
data = [
  { water: 9, retort_food: 3, mask: 3 },
  { water: 10, retort_food: 4, mask: 4 },
  { water: 11, retort_food: 5, mask: 5 }
]

# 上記のデータで同じキーのものを合算
# data = { water: 30, retort_food: 12, mask: 12 }
```

## 完成形
```
merge_data = data.inject do |old_data, new_data|
  old_data.merge(new_data) do |_key, old_val, new_val|
    old_val + new_val
  end
end
```
## 使用したメソッド

### inject
> 配列等の要素を一つずつ繰り返して、ブロック内で処理する

参考：https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/inject.html

### merge
> 同一のキーを持つ値を結合する
> ブロック付きの場合、ブロックを呼び出してその返す値を重複キーに対応する値にする。

参考：https://docs.ruby-lang.org/ja/latest/method/Hash/i/merge.html

injectで配列内の要素を一つずつ取り出して、mergeにより同一キーをもつ値を結合していく処理ができました！
