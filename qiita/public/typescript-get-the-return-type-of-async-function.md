---
title: TypeScriptでasync関数の戻り値の型を取得する
tags:
  - TypeScript
  - 非同期関数
  - prisma
private: false
updated_at: '2024-08-11T20:00:42+09:00'
id: 27699ac090dd1b71980f
organization_url_name: null
slide: false
ignorePublish: false
---

TypeScriptで開発を行う際、特にPrismaのようなライブラリを使用すると、複雑な型の関数に直面することがよくあります。この記事では、TypeScriptのユーティリティ型を活用して、非同期関数の戻り値の型を取得する方法を紹介します。

#### `ReturnType`で関数の戻り値の型を取得する

まず、TypeScriptのユーティリティ型[`ReturnType`](https://www.typescriptlang.org/docs/handbook/utility-types.html#returntypetype)を使用して、関数の戻り値の型を取得する方法を見ていきます。以下のようなPrismaを使用した関数があるとします。

```typescript
type FuncReturnType = ReturnType<typeof getPostsForUser>
```

`ReturnType`を使用することで、`getPostsForUser`関数の戻り値の型を取得できます。しかし、この関数が非同期関数である場合、戻り値の型は`Promise`に包まれた状態になります。

#### `Awaited`で`Promise`を解除する

非同期関数の戻り値の型を取得する際には、その型が`Promise`に包まれているため、これを解除する必要があります。ここで、TypeScriptの[`Awaited`](https://www.typescriptlang.org/docs/handbook/utility-types.html#awaitedtype)型を使用します。

```typescript
type FuncReturnType = ReturnType<typeof getPostsForUser>
type ResolvedFuncReturnType = Awaited<FuncReturnType>
```

`Awaited`を使用することで、`Promise`に包まれた型を解除し、関数の実際の戻り値の型を取得できます。

#### 配列の要素の型を取得する

多くの場合、Prismaでクエリを実行すると、リスト形式のデータが返されます。この場合、配列の要素の型を取得する必要があります。TypeScriptでは、配列の型から要素の型を取得するために、インデックス型`[number]`を使用します。

```typescript
type FuncReturnType = ReturnType<typeof getPostsForUser>
type ResolvedFuncReturnType = Awaited<FuncReturnType>
type PostType = ResolvedFuncReturnType[number]
```

これにより、配列の各要素の型（ここでは`PostType`）を取得することができます。

### まとめ

これらのステップをすべて一つの行にまとめると、次のようになります。

```typescript
type Post = Awaited<ReturnType<typeof getPostsForUser>>[number]
```

この一行で、非同期関数`getPostsForUser`の戻り値の型から、配列の各要素の型`Post`を取得することができます。TypeScriptのユーティリティ型を駆使することで、複雑な型操作もシンプルに行うことができるようになります。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
