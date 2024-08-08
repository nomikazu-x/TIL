---
title: TypeScriptのインデックスアクセス型を使ったオブジェクト型からユニオン型への変換テクニック
tags:
  - TypeScript
private: false
updated_at: '2024-08-08T20:00:45+09:00'
id: 2ecc9610d060ed3478b9
organization_url_name: null
slide: false
ignorePublish: false
---

この記事では、TypeScriptのインデックスアクセス型を使用してオブジェクト型から値を抽出し、それをユニオン型に変換する方法について解説します。TypeScriptを使用する際に便利なテクニックの一つであり、オブジェクト型の各値にアクセスしたり、それを効率的に型として扱うことができます。以下では、具体的な例を通じてその方法を見ていきましょう。

---

## TypeScriptのインデックスアクセス型とは？

まず、TypeScriptのインデックスアクセス型について説明します。インデックスアクセス型は、JavaScriptのオブジェクトアクセスに似た方法で、型から特定のプロパティの型を抽出する機能です。

たとえば、以下のようなオブジェクト型があるとします。

```typescript
type GlobalEvent = {
    addTodo: {
        text: string
    }
    logIn: {
        email: string
    }
    deleteTodo: {
        todo_id: number
    }
}
```

この型から`ADD_TODO`の値の型を取り出したい場合、インデックスアクセス型を使用します。

```typescript
type AddTodoType = GlobalEvent['addTodo'];
/*
type AddTodoType = {
  text: string
}
*/
```

上記のように、`GlobalEvent`のキーに対してインデックスアクセスを行うことで、特定のキーに対応する値の型を取得できます。

## オブジェクト型の値をユニオン型に変換する

次に、オブジェクト型の全ての値をユニオン型に変換する方法について見ていきます。これには、TypeScriptの`keyof`演算子を使用します。

```typescript
type TypesForEvents = GlobalEvent[keyof GlobalEvent];
/*
type TypesForEvents = {
  text: string
} | {
  email: string
} | {
  todo_id: number
}
*/
```

この例では、`keyof GlobalEvent`によって`'addTodo' | 'logIn' | 'deleteTodo'`という型が生成され、それをインデックスアクセスで利用することで、オブジェクトのすべての値を含むユニオン型`TypesForEvents`を取得できます。これにより、オブジェクトの各プロパティの型をユニオン型として簡単に扱うことが可能になります。

## ユニオン型とマップ型の組み合わせの活用法

インデックスアクセス型をユニオン型と組み合わせると、より高度な型操作が可能になります。たとえば、マップ型と組み合わせて、オブジェクトの各プロパティに対して特定の型を適用することができます。

インデックスアクセス型を使用することで、型の操作がより柔軟になり、コードの再利用性や可読性が向上します。特に、大規模なコードベースで複雑な型を扱う際に非常に役立ちます。

---

## まとめ

TypeScriptのインデックスアクセス型を利用することで、オブジェクト型から特定の値を抽出したり、ユニオン型を生成したりすることができます。これにより、より強力で柔軟な型定義が可能となり、型安全性を確保しながらコードの品質を向上させることができます。TypeScriptを使っている方は、ぜひこのテクニックを活用してみてください。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P
