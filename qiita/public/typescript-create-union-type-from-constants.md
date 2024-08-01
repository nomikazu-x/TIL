---
title: 定数からユニオン型を作成する方法
tags:
  - TypeScript
private: false
updated_at: '2024-08-01T20:00:48+09:00'
id: 9ec849a51a263702be5a
organization_url_name: null
slide: false
ignorePublish: false
---

## 定数にマジック文字列をキャプチャする利点

コード内で頻繁に使用する特定の文字列を定数（実際には変数）としてキャプチャすることを好みます。こうすることで、その文字列の値に何か変更があった場合、単一の場所で更新するだけで済むため、メンテナンスが最小限で済みます。

この再利用の概念を型システムにも拡張したいと考えています。

## 定数からユニオン型を作成する

例えば、以下のような定数を定義しているとします。

```typescript
const UPGRADE = "upgrade";
const DOWNGRADE = "downgrade";
```

これらの値からユニオン型を作成するために、[`typeof`演算子](https://www.typescriptlang.org/docs/handbook/2/typeof-types.html)を使用します。

```typescript
type IntervalChange = typeof UPGRADE | typeof DOWNGRADE;
//=> type IntervalChange = 'upgrade' | 'downgrade'
```

## コード全体で定数と型を活用する

このようにして作成したユニオン型と定数を使用することで、コード全体で一貫したメンテナンスを行うことができます。

```typescript
function checkForUpgrade(interval: string): IntervalChange {
  // いくつかのロジック
  const result = ...;

  return result ? UPGRADE : DOWNGRADE;
}
```

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P
