---
title: 同じ名前のインターフェースは結合されます！
emoji: 🤖
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - typescript
  - インターフェース
published: true
---

TypeScriptでは、インターフェースの宣言が同じ名前で複数回行われた場合、それらのインターフェースは結合されます。この記事では、同じ名前のインターフェースがどのように結合されるのかを説明します。

#### 基本的なインターフェースの宣言

まず、以下のように基本的なインターフェースを宣言します。このインターフェース`Person`は、`name`というプロパティを持つオブジェクトを定義します。

```typescript
interface Person {
  name: string
}
```

このインターフェースを基に、`name`プロパティを持つ`Person`型のオブジェクトを作成できます。

#### 同じ名前で別のインターフェースを追加する

ここで、同じ名前`Person`で別のインターフェースを宣言し、`age`という新しいプロパティを追加してみます。

```typescript
interface Person {
  age: number
}
```

TypeScriptでは、同じ名前のインターフェースが宣言されると、これらは結合されます。つまり、`Person`型は`name`と`age`の両方のプロパティを持つようになります。

#### 結合されたインターフェースを使用する

インターフェースが結合された結果、以下のように`Person`型のオブジェクトは`name`と`age`の両方のプロパティを持つことができます。

```typescript
const person: Person = {
  age: 22,
  name: 'Bob'
}
```

このように、同じ名前のインターフェースを複数回宣言すると、プロパティが結合され、より豊かな型定義が可能になります。

TypeScriptのインターフェース結合機能は、柔軟で強力な型定義を行う際に非常に便利です。TypeScriptのPlaygroundで[実際の例](https://www.typescriptlang.org/play?ssl=12&ssc=2&pln=5&pc=1#code/JYOwLgpgTgZghgYwgAgArQM4HsTIN4BQyxyIcAthAFzIZhSgDmBAvgQaJLIiulNrkIlkcRtVIBXcgCNordghx1kAB0w4afAcgC8+IiVHiATMYA0B4mUo0A5ACEs02-IJr+OAHRGgA)を確認することもできます。


## 【ご案内】フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P