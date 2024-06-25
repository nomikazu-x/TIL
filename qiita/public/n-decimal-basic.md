---
title: 【基本情報技術者】n進数とは何かを解説
private: false
tags:
  - 基本情報技術者
  - n進数
  - Web
updated_at: '2024-06-25T12:53:09.940Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

n進数について勉強したため、アウトプットのため記事にしたいと思います。

## 進数

「N 進法」（エヌしんほう）とも呼ぶ。あらかじめ定められたN 種類の記号（数字）を列べることによって数を表す方法。N 進法で表記された数という意味で「N 進数」（エヌしんすう）と呼ぶことがある。
引用: https://ja.wikipedia.org/wiki/%E9%80%B2%E6%95%B0

nには数字が入って、n種類の記号で数字を表現するということです。
我々が普段使っている数字は0〜9まで数えたら次は桁が繰り上がって10となります。
この表現の仕方を10進数や10進法と言います。

`0, 1, 2, 3, 4, 5, 6, 7, 8, 9`
上記の10種類の記号を使って表しているから10進数です。

8進数で表すと、
`0, 1, 2, 3, 4, 5, 6, 7`
上記の8種類の記号で数を表現します。
7まで数字を数えたら次は10になって10~17まで数えたら次は20となるわけです。

そして、コンピュータは2進数でデータの処理を行っています。
つまり0, 1だけで表現しています。
「2進数で0から順番に数えてください」と言われたら

`0, 1, 10, 11, 100, 101, 110, 111, 1000 ...`
となります。

2進数で物事を考えるコンピュータは8進数や16進数との相性がいいと言えます。
2進数で7までの数字を表現しようとすると0~111と三桁まで使いますが、8進数は一桁で2進数でいう111までを表現できます。

16進数も同様で0~15までを２進数で表現すると0~1111の四桁いっぱいを使いますが、16進数だと一桁で表現できます。

8進数と16進数は２進数でいうちょうど3桁いっぱい表現してくれる、ちょうど4桁いっぱいを表現してくれるという理由で相性がいいのです。

## 16進数

我々は普段10進数で数字を表現しているので9の次は桁が繰り上がり、その10を一桁で表現する方法を知りません。

結論を言うと、16進数では9の次はAです。アルファベットで表現していきます。
`0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F`
この16種類で一桁を表現します。

Fまで数えて次が10です。
1Fまで数えて20です。
これが16進数です。

## 基数変換（n進数でいう○○）

n進数のnの部分を基数と言います。例えば、10進数なら10が基数です。

いろんな基数での数字の表現の仕方を学んだので、ここからは「n進数でいう○○」という考え方が非常に重要です。

例えば16進数のFは10進数でいう15だよね。と言う変換ですね。

2進数の1000は10進数の8。みたいな感じです。

これを基数変換と言います。
数えられるくらいのものであれば頭の中や紙に書き出すことで導き出せると思いますが、更に大きな数字で、小数点も入ってくると分かりづらいですね。

## n進数の重み

n進数を10進数に変換したいときは、n進数の重みについて学ばなければなりません。

例えば2進数であれば、桁が増えたときに10進数ではどの数字を表しているか見てみましょう。

`1, 10, 100, 1000, 10000, 100000, 1000000 ...`

上記が2進数で桁が増えた時の数字です。
これを10進数で表します。この程度であれば頭の中でできますね。

`1, 2, 4, 8, 16, 32, 64 ...`

これでわかるように、桁が増えるごとに倍になっていっています。
2の(桁数-1)乗と考えると楽です。

これが2進数の桁の重みと言います。

小数点の桁の重みは、2進数の場合は小数第一位から、
`1/2, 1/4, 1/8, 1/16 ...`
となっていきます。

## 10進数へ基数変換
重みが理解できたら、10進数に変換する方法を説明します。

1. それぞれの桁にその桁の重みをかけます。
2. 全部の結果を足し算をする

これだけです。
例えば2進数の110.011を10進数に直してくださいという問題の場合、

```
1 1 0 . 0 1 1
↓ ↓ ↓ ↓ ↓ ↓
×4 ×2 ×1 ×1/2 ×1/4 ×1/8
↓ ↓ ↓ ↓ ↓ ↓
4 2 0 0 0.25 0.125

上記の結果を全て足すと
=> 6.375
```

## 最後に

基数変換はこのn進数を10進数に直す以外にも、10進数の数字を2進数へ変換したり、2進数の数字を16進数に変換したりすることが想定できます。

それらの変換の仕方はまた別になります。今回は省いておきます。
また、説明できる時がきたら記事にまとめたいと思います。

参考: キタミ式イラストIT塾基本情報技術者
https://amzn.to/4eBjV2S