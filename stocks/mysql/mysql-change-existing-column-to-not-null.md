---
title: 【MySQL】既存のカラムをNot Nullに変更する方法
emoji: 🤖
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - MySQL
  - SQL
  - データベース
published: true
---

既存のNULLを許容するカラムがあり、そのカラムに対して`not null`制約を強制するためにスキーマを更新したいとします。

## カラムをNot Nullに変更する方法
これを行うには、[`alter table`](https://dev.mysql.com/doc/refman/8.0/en/alter-table.html) DDLステートメントを使用します。`modify`または`change`オプションを使用して実行できます。

`modify`を使用すると、既存のデータ型を知って指定する必要がありますが、カラム定義を再宣言して、必要なオプションを追加できます。

```sql
alter table books modify created_at int not null;
```

`change`オプションを使用してこれを行うことも可能ですが、カラム名を2回宣言する必要があるため、やや面倒です。`change`は通常、カラムの名前を変更するために使用されます。

```sql
alter table books change created_at created_at datetime not null;
```

データが既に存在するテーブルのカラムを更新する場合、そのカラムに`null`が含まれている既存のレコードをバックフィルしなければなりません。`modify`を適用する前に、そのカラムのすべてのレコードに値を設定する必要があります。

参考：https://stackoverflow.com/a/6305252/535590

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P