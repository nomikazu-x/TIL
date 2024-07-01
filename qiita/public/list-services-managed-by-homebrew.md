---
title: Homebrewで管理されているすべてのサービスを一覧表示する方法
private: false
tags:
  - Homebrew
  - MacOS
  - Terminal
updated_at: '2024-07-01T09:18:08.675Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに

Homebrew（略してBrew）は、macOSで使えるパッケージ管理システムです。Homebrewを使えば、様々なソフトウェアやライブラリを簡単にインストール、アップデート、アンインストールすることができます。この記事では、Homebrewを使ってインストールおよび管理できるデーモン化されたサービスを一覧表示する方法について詳しく説明します。

## Brewのサービス管理とは

デーモン化されたサービスとは、バックグラウンドで動作するプロセスのことを指します。例えば、データベースのPostgreSQLやMySQL、メールキャプチャツールのMailHogなどが該当します。

macOS上でこれらのサービスを管理するために、Homebrewは`launchctl`というシステムツールを使用します。`launchctl`はサービスの起動、停止、再起動を行うためのツールです。

## インストール済みのサービスを確認する方法

Homebrewでサービスをインストールした場合、`brew services list`コマンドを使って、現在インストールされているサービスとその状態を確認できます。このコマンドを実行することで、どのサービスが実行中で、どのサービスが停止中かを一目で把握できます。

```bash
$ brew services list
Name          Status  User       File
mailhog       none
mysql         none
postgresql@11 started jbranchaud ~/Library/LaunchAgents/homebrew.mxcl.postgresql@11.plist
postgresql@13 none
postgresql@16 none
unbound       none
```

上記の出力例では、`postgresql@11`が実行中で、他のサービスはすべて停止しています。特に複数バージョンのPostgreSQLがインストールされている場合に、どのバージョンが動作しているかを確認するのに便利です。

## サービスの開始と停止

特定のサービスを開始または停止したい場合は、`brew services start`および`brew services stop`コマンドを使用します。例えば、`postgresql@11`を停止して`postgresql@16`を開始するには、以下のコマンドを順に実行します。

```bash
$ brew services stop postgresql@11
Stopping `postgresql@11`... (might take a while)
Successfully stopped `postgresql@11` (label: homebrew.mxcl.postgresql@11)
```

```bash
$ brew services start postgresql@16
Starting `postgresql@16`... (might take a while)
Successfully started `postgresql@16` (label: homebrew.mxcl.postgresql@16)
```

これにより、現在のPostgreSQLバージョンを切り替えることができます。

## その他の便利なコマンド
Homebrewには、他にもいくつかの便利なコマンドがあります。例えば、すべてのサービスを一度に再起動したい場合は、`brew services restart --all`コマンドを使用します。また、特定のユーザーでサービスを実行したい場合は、`--user`オプションを付けることができます。

```bash
$ brew services restart --all
```

```bash
$ brew services start postgresql@16 --user=<username>
```

## まとめ
Homebrewを使ってデーモン化されたサービスを管理する方法について紹介しました。`brew services list`コマンドを使えば、インストールされているサービスとその状態を簡単に確認できます。また、サービスの開始、停止、再起動もコマンド一つで行えるため、非常に便利です。詳細なコマンドオプションについては、`brew services --help`を参照してください。