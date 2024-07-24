---
title:オブジェクトのデストラクチャリングに型を追加する方法
emoji: 🤖
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - typescript
  - javascript
  - 型
  - デストラクチャリング
published: true
---

フォームコンポーネントを作成しているとします。ユーザーに名前とメールアドレスを入力させ、その値をサーバーに送信してニュースレターに登録するような機能を持たせる場合を考えます。

では、フォームの値をデストラクチャリングする際に型を付けたい場合はどうするでしょうか？

通常のTypeScriptの構文は、ES6のデストラクチャリングとリネーム機能と競合します。

```javascript
const { firstName: string, email: string } = formValues;
```

これは動作しません。

## デストラクチャリングされたオブジェクトに型を付ける

デストラクチャリングされた個々の値に型を付けるのではなく、デストラクチャリングされたオブジェクト自体に型を付ける必要があります。

```typescript
const {
  firstName,
  email,
}: { firstName: string; email: string } = formValues;
```

以上の方法を使用することで、オブジェクトのデストラクチャリングに型を追加することができます。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P
