---
title: Homebrewの環境変数を設定する方法
private: false
tags:
  - Homebrew
  - MacOS
  - Terminal
updated_at: '2024-07-11T11:00:09.452Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

## Homebrewの環境変数のデフォルト値
`brew` CLI では、さまざまな環境変数が設定されています。これらのデフォルト値一覧は、[ドキュメントの環境セクション](https://docs.brew.sh/Manpage#environment)で確認できます。

## 環境変数の変更方法
これらのデフォルト値を変更したい場合、あなたの環境に直接設定できます。

```bash
$ set HOMEBREW_API_AUTO_UPDATE_SECS=450
```
または、専用のenvファイルに環境変数を設定することもできます。ファイルの場所はいくつかありますが、 `$HOME/.homebrew/brew.env`（例：~/.homebrew/brew.env）を使用することをお勧めします。

```~/.homebrew/brew.env
HOMEBREW_API_AUTO_UPDATE_SECS=450
```

このファイルとディレクトリは存在しない可能性があるので、初めて設定する場合は以下のコマンドで作成してください。

```bash
$ mkdir $HOME/.homebrew
$ touch $HOME/.homebrew/brew.env
```

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる限定の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://bit.ly/3xLrLGw
