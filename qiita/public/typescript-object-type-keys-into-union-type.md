---
title: TypeScriptのオブジェクト型からユニオン型へ！キーを活かした型定義法
tags:
  - TypeScript
private: false
updated_at: '2024-08-06T20:00:56+09:00'
id: 18668c47d559dfa275cd
organization_url_name: null
slide: false
ignorePublish: false
---

## オブジェクト型とその利用方法

オブジェクト型は、TypeScriptにおいて、複雑なデータ構造を表現するための手段として使用されます。たとえば、以下のようにリデューサーが処理できるイベントの種類を定義するために利用されます。

```typescript
interface GlobalEvent {
    addTodo: {
        text: string
    }
    login: {
        email: string
    }
    deleteTodo: {
        todo_id: number
    }
}
```

この例では、`GlobalReducerEvent`インターフェースに3つのイベントタイプを持つオブジェクト型を定義しています。それぞれのキーはイベントの名前を表し、値はそのイベントに関連するデータの型を定義します。この構造により、コードの可読性が向上し、データを一元管理できます。

## `keyof`演算子でユニオン型を生成する方法

`keyof`演算子を使用することで、オブジェクト型からそのキーをユニオン型として抽出できます。以下に例を示します。

```typescript
type EventTypes = keyof GlobalEvent;
//=> 'addTodo' | 'login' | 'deleteTodo'
```

このコードは、`GlobalEvent`インターフェースのキーをユニオン型として抽出し、新しい型`EventTypes`を生成しています。この結果、`EventTypes`は `'addTodo' | 'login' | 'deleteTodo'` というユニオン型となります。

### `keyof`を使う利点

`keyof`演算子を使うことで、以下のような利点があります。

- **コードの柔軟性:** オブジェクトの構造に変更があった場合でも、ユニオン型は自動的に更新されるため、メンテナンスが容易です。
- **型の安全性:** 型システムがキーの誤りを防ぐため、実装時のエラーを減らすことができます。
- **再利用性の向上:** ユニオン型を使うことで、型定義を他の部分に再利用でき、コードの重複を避けられます。

## ユニオン型の応用例

`keyof`演算子で生成されたユニオン型は、他の型と組み合わせて様々な用途に活用できます。例えば、ユニオン型を用いてスイッチケースでイベントを処理する関数を作成することができます。

```typescript
function handleEvent(eventType: EventTypes, payload: any) {
    switch (eventType) {
        case 'addTodo':
            console.log(`Adding todo: ${payload.text}`);
            break;
        case 'login':
            console.log(`Logging in user with email: ${payload.email}`);
            break;
        case 'deleteTodo':
            console.log(`Deleting todo with id: ${payload.todo_id}`);
            break;
        default:
            console.error('Unknown event type');
    }
}
```

この関数では、`EventTypes`ユニオン型を用いることで、イベントタイプに応じた処理を行うことができます。`switch`文によるイベントのハンドリングが明確に記述でき、コードの可読性と保守性が向上します。

TypeScriptの`keyof`演算子を使用してオブジェクトのキーをユニオン型に抽出することで、型システムを活用した柔軟で安全なコードを書くことができます。ぜひこのテクニックを活用して、プロジェクトの型定義をより効果的に管理してみてください。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P
