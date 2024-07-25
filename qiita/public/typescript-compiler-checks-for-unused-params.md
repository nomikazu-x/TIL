---
title: TypeScriptコンパイラによる未使用パラメータと変数のチェック
private: false
tags:
  - typescript
  - javascript
  - tsconfig
  - コンパイラ
updated_at: '2024-07-25T11:00:11.564Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

TypeScriptコンパイラには、コードをチェックする際にリンターのような機能を持つオプションがあります。その中には、パラメータや変数が未使用のままになっていることを防ぐものがあります。

### `noUnusedLocals`オプション

`noUnusedLocals`は、デフォルトでは`false`に設定されていますが、これを`true`に設定すると、未使用のローカル変数がある場合にコンパイラがエラーを出すようになります。以下のコード例を見てみましょう。

```typescript
function printItem(item: any, index: number) {
  const indexedItem = `${index}: ${item}`;
  //    ^^^ 'indexedItem' is declared but its value is never read.

  console.log(item);
}
```

上記のコードでは、`indexedItem`という変数が宣言されていますが、その値が一度も使用されていないため、コンパイラがエラーを出します。

### `noUnusedParameters`オプション

同様に、`noUnusedParameters`もデフォルトでは`false`に設定されていますが、これを`true`に設定すると、未使用の関数パラメータがある場合にコンパイラがエラーを出すようになります。以下のコード例を見てみましょう。

```typescript
function printItem(item: any, index: number) {
  //                          ^^^
  // 'index' is declared but its value is never read.

  console.log(item);
}
```

この場合、`index`パラメータが宣言されていますが、その値が一度も使用されていないため、コンパイラがエラーを出します。

### `tsconfig.json`の設定例

以下に、これらのオプションを有効にした`tsconfig.json`の設定例を示します。

```json
{
  "compilerOptions": {
    "noUnusedLocals": true,
    "noUnusedParameters": true
  }
}
```

これにより、TypeScriptコンパイラは未使用のローカル変数やパラメータがないかどうかをチェックし、エラーを出すようになります。この設定を使用することで、コードの品質を向上させ、不要な変数やパラメータを削除することでコードの可読性とメンテナンス性を向上させることができます。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P