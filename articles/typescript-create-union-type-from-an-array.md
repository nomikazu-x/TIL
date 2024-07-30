---
title: 配列からユニオン型を作成する方法
emoji: 🤖
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - TypeScript
published: true
---
## 配列からユニオン型を作成する

プログラムが処理できる一連の _アクション_ を含む配列があるとします。

```typescript
// 推論された型: string[]
const actions = ['increase', 'decrease', 'reset'];
```

この配列の推論された型は `string[]` であり、非常に広範な型です。このままではあまり活用できません。配列の推論された型の広がりを防ぐために `as const` を使用できます。

## 推論された型の固定化

```typescript
// 推論された型: readonly ['increase', 'decrease', 'reset']
const actions = ['increase', 'decrease', 'reset'] as const;
```

この推論された型は特定の値に限定されるため、ユニオン型の作成などに活用できます。

## ユニオン型の作成

```typescript
const actions = ['increase', 'decrease', 'reset'] as const;

type Actions = typeof actions[number];
//=> type Actions = 'increase' | 'decrease' | 'reset'
```

`Actions` 型を使用して、関数が既知のアクションに対応する値のみを受け取るように指定できます。


## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P