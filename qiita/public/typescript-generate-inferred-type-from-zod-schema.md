---
title: TypeScriptでZodスキーマから推論される型を生成する
private: false
tags:
  - TypeScript
  - Zod
updated_at: '2024-08-10T11:00:09.628Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

`Zod`は、スキーマを定義してランタイムチェックを行うだけでなく、そのスキーマから型を推論して、静的な型チェックに利用することも可能です。この記事では、Zodを使ってスキーマから型を推論する方法を紹介します。

#### Zodでスキーマを定義する

まず、`Zod`を使ってスキーマを定義します。ここでは、コンタクト情報を表すスキーマを例にします。このスキーマでは、`person`オブジェクトの中に`firstName`と`lastName`という文字列のプロパティがあり、`email`はメールアドレス形式の文字列であることを定義しています。

```typescript
import {z} from 'zod'

const contactSchema = z.object({
  person: z.object({
    firstName: z.string(),
    lastName: z.string()
  }),
  email: z.string().email(),
})
```

このように、`Zod`を使ってオブジェクトのスキーマを簡単に定義することができます。

#### Zodでスキーマから型を推論する

次に、Zodの[`z.infer()`](https://github.com/colinhacks/zod#type-inference)関数を使って、定義したスキーマから型を推論し、その型を関数の引数として利用します。

```typescript
const createContact = (data: z.infer<typeof contactSchema>) => {
  // ...
}
```

この`data`の型を調べてみると、`contactSchema`に基づいて自動的に生成された型が得られます。具体的には、以下のような型になります。

```typescript
/* data: {
 *    person: {
 *        firstName: string;
 *        lastName: string;
 *    };
 *    email: string;
 * }
 */
```

これにより、`createContact`関数に渡されるデータがスキーマに基づいて正しい型を持っていることを保証できます。

#### 推論された型を再利用する

スキーマから推論された型が複雑になる場合、その型を別途定義し、再利用できるようにすることができます。これにより、コードがより整理され、他のモジュールでも型を利用することが容易になります。

```typescript
export type Contact = z.infer<typeof contactSchema>

const createContact = (data: Contact) => {
  // ...
}
```

`Contact`という型をエクスポートすれば、他のファイルやモジュールでもこの型を使用できます。これにより、コードの可読性と再利用性が向上します。

Zodを使うことで、スキーマ定義と型の推論が一体化し、型安全な開発が可能になります。プロジェクトの規模が大きくなるほど、このようなツールが役立つ場面が増えていくでしょう。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P