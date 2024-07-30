---
title: 空ではない配列型を作成する方法
emoji: 🤖
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - TypeScript
published: true
---

## 空ではない配列型の作成

配列型（例えば、`Array<string>`）はデフォルトで空の配列を許可します。しかし、配列が空で宣言されないようにする静的型チェックを行うカスタム配列型を定義することができます。

これを実現するために、配列型には少なくとも1つのアイテムがあることを指定し、さらに残りの配列の要素をスプレッド演算子で表現します。

```typescript
type NonEmptyArray<T> = [T, ...T[]];
```

## アイテムがない `NonEmptyArray` を宣言する場合

以下のように `NonEmptyArray` をアイテムなしで宣言すると：

```typescript
const statuses: NonEmptyArray<string> = [];
```

次のような型エラーが発生します：

```
Type '[]' is not assignable to type 'NonEmptyArray<string>'.
  Source has 0 element(s) but target requires 1.
```

## 少なくとも1つのアイテムを追加すると型エラーが解消される

一方で、少なくとも1つのアイテムを追加すると、型エラーは解消されます。

```typescript
const statuses: NonEmptyArray<string> = ['active'];
```

この型の [TS Playground の例](https://www.typescriptlang.org/play?#code/C4TwDgpgBAcg9gOwKIFsygIICcsEMQA8AKgHxQC8UA2kQDRQB0TRVAuqwNwBQXAxogGdgUCGlABlYLmABXARAEAuWIlToQ2PISFYAlggDmZSm259BwodLkLl8ZGI058BHfqMVqAcly9gugDcIL04gA) はこちらです。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P