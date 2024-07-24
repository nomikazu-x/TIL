---
title: MySQLで新しいインスタンスを作成した場合のデフォルトのユーザー名とパスワード
tags:
  - MySQL
  - SQL
  - Database
private: false
updated_at: '2024-07-24T20:00:46+09:00'
id: bb9689573a22e2232a87
organization_url_name: null
slide: false
ignorePublish: false
---

## 新しいMySQLインスタンスの設定

新しいMySQLインスタンスをセットアップしたとします。例えば、MySQLイメージを使用してDockerコンテナ内に設定した場合です。初めてインスタンスに接続すると、ユーザー名とパスワードの入力を求められます。

## デフォルトのユーザー名とパスワード

新しく作成したMySQLインスタンスのデフォルトのユーザー名とパスワードは何でしょうか？

- デフォルトのユーザー名：`root`
- デフォルトのパスワード：空白

そのため、接続URLは以下のようになります。

```plaintext
mysql://root@localhost:3306
```

このURLをCLIで使用するか、お気に入りのSQLクライアントの接続詳細パネルに入力して使用できます。

参考：https://dev.mysql.com/doc/refman/8.0/en/default-privileges.html

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P
