---
title: 【MySQL】Safe Updates モードでデータベースに接続する方法
private: false
tags:
  - Linux
  - MacOS
  - 基礎
updated_at: '2024-07-16T13:15:31.227Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

## Safe Updates モードって？
MySQLクライアントには、データベースに接続する際に使用できる「Safe Updatesモード」があります。このモードがアクティブな場合、クライアントは、キー値でフィルタリングする`where`句を指定していない`update`および`delete`コマンドを中断します。クエリによって影響を受ける行数を明示的に`limit`する必要があります。

## Safe Updates モードで接続する方法
このモードで接続を開始するには、`--safe-updates`フラグまたはもう1つのフラグ`--i-am-a-dummy`を使用することができます。

```bash
$ mysql --i-am-a-dummy -h ::1 -P 3309 -u root -D my-database
```

`where`句を指定していない`update`または`delete`を試みると、次のメッセージが表示されます。

```sql
mysql> update users set email = 'hogehoge@email.com';
ERROR 1175 (HY000): You are using safe update mode and you tried to update
a table without a WHERE that uses a KEY column.
```

この設定は、接続中にも以下のように設定できます。ぜひご活用ください！

```sql
mysql> set sql_safe_updates=1;
```

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P
