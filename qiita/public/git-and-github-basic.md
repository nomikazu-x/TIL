---
title: 徹底解説！Git・GitHubに関する基礎知識とコマンド
private: false
tags:
  - Git
  - GitHub
  - 基礎
updated_at: '2024-06-25T14:10:34.396Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

Git、GitHubについて超基礎知識からまとめてみた。

## 基礎知識

- バージョン管理とは、
  - ソースコードをはじめとしたファイルのバージョン(変更履歴)を管理すること。
  - ファイルの追加および変更の履歴を管理することで、過去の変更箇所の確認や特定の時点に戻せるなどができる。
  - これがないと、チーム開発でメンバー間での連携が困難になり、生産性が損なわれる。

- Gitとは、
  - バージョン管理をするためのシステム。
  - 特徴としては、「分散型」のバージョン管理システム。
  - 「集中型」：特定の場所にあるリポジトリへの接続が必須。
  - 「分散型」：個々人のマシン上(ローカル)にリポジトリを作成して開発を行うことができ、現在のチーム開発における主流。

- リポジトリとは、
  - バージョン管理によって管理されるファイルと履歴情報を保管する領域。
  - Gitでは、まずは個々人のリポジトリ(ローカルリポジトリ)上で作業を実施後、作業内容をネットワーク先のサーバー状などにあるリポジトリ(リモートリポジトリ)に集約する流れで開発を進めていく。

- GitHubとは、
  - 複数人のエンジニアがリモートリポジトリとして活用する他、チーム開発を行うための機能を提供するWebサービス。
  - コードレビュー機能やWikiなどのコミュニケーションツールとしての機能を持ち、組織規模を問わず、多くの企業・団体がソフトウェア開発で利用している。

## チーム開発
チームで他のメンバーと開発と行う際にブランチ(branch)という仕組みを使いこなす必要がある。

1. リポジトリをクローン(clone)する
新たに開発現場に参加することになったら、リモートリポジトリからソースコードを取得することになる。

2. ブランチを作成する
同時進行で複数のバージョンの開発や突発的なバグ対応などにより新たにリリースするバージョンとは別軸で対応する必要が多々でてくる。そのためにブランチ(branch)を作成し、その中で作業する。

3. ブランチでコミットする

4. リモートリポジトリにプッシュする
リモートリポジトリ(GitHub)にもブランチの変更内容を反映させる。
現段階では、プッシュ先ではないmasterには変更内容が反映されてない。

5. コードレビュー・マージ
ブランチでの開発作業が完了したら、メインブランチ(master)に変更内容を取り込み、開発内容を統合する(マージ)。
このマージを行う際、GitHub上ではプルリクエスト機能を使い、コードレビューを行える。指摘がある場合にはコメントを追加・修正を促せる。

6. リモートリポジトリからプルする
リモートリポジトリのmasterにはマージされたが、ローカルリポジトリ上のmasterにはまだ内容が反映されいない。そのため、プル(pull) 操作を行うことで、リモートリポジトリから変更内容を取得できる。

## コマンド一覧

### ローカルリポジトリの新規作成
```git
git init
```

### Gitリポジトリのコピーを作成
```git
git clone <リポジトリ名>
```

### 変更をステージに追加する
```git
git add <ファイル名>
git add <ディレクトリ名>
git add .
```
### 変更を記録する(コミット)
```
git commit
git commit -m "<メッセージ>"
git commit -v
```
### 現在の変更状況を確認する
```
git status
```
### 変更差分を確認する

# git addする前の変更分
```
git diff
git diff <ファイル名>
```
# git addした後の変更分
```
git diff --staged
```
### 変更履歴を確認する
```
git log
```
# 一行で表示する
```
git log --oneline
```
# ファイルの変更差分を表示する
```
git log -p index.html
```
# 表示するコミット数を制限する
```
git log -n <コミット数>
```
### ファイルの削除を記録する

# ファイルごと削除
```
git rm <ファイル名>
git rm -r <ディレクトリ名>
```
# ファイルを残したいとき
```
git rm --cached <ファイル名>
```
### ファイルの移動を記録する
```
git mv <旧ファイル> <新ファイル>
```
# 以下のコマンドと同じ
```
mv <旧ファイル> <新ファイル>
git rm <旧ファイル>
git add <新ファイル>
```
### リモートリポジトリ(GitHub)を新規追加する
```
git remote add origin https://github.com/username/repo.git
```
### リモートリポジトリ(GitHub)へ送信する
```
git push <リモート名> <ブランチ名>
git push origin master
```
### コマンドにエイリアスを付ける
```
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global alias.co checkout
```
### 管理しないファイルをGitの管理から外す
```
.gitignore

# 指定したファイルを除外
index.html

# ルートディレクトリを指定
/root.html

# ディレクトリ以下を除外
dir/

# /以外の文字列にマッチ「*」
/*/*.css
```
## 変更を元に戻すコマンド

### ファイルへの変更を取り消す
```
git checkout -- <ファイル名>
git checkout -- <ディレクトリ名>

# 全変更を取り消す
git checkout -- .
```
### ステージした変更を取り消す
```
git reset HEAD <ファイル名>
git reset HEAD <ディレクトリ名>

# 全変更を取り消す
git reset HEAD .
```
### 直前のコミットをやり直す
```
git commit --amend
```
## GitHubとやり取りするコマンド

### リモートを表示する
```
git remote
```
# 対応するURLを表示
```
git remote -v
```

### リモートリポジトリを新規追加する
```
git remote add <リモート名> <リモートURL>
git remote add tutorial https://github.com/username/repo.git
```
### リモートから情報を取得する (フェッチ)
```
git fetch <リモート名>
git fetch origin
```
### リモートから情報を取得してマージする (プル)
```
git pull <リモート名> <ブランチ名>
git pull origin master

# 上記コマンドは省略可能

git pull

# これは下記コマンドと同じこと
git fetch origin master
git merge origin/master
```
### リモートの詳細情報を表示する
```
git remote show <リモート名>
git remote show origin
```
### リモートを変更・削除する
```
# 変更する
git remote rename <旧リモート名> <新リモート名>
git remote rename tutorial new_tutorial

# 削除する
git remote rm <リモート名>
git remote rm new_tutorial
```
## ブランチとマージのコマンド

### ブランチを新規追加する
```
git branch <ブランチ名>
git branch feature
```
### ブランチの一覧を表示する
```
git branch

# 全てのブランチを表示する
git branch -a
```
### ブランチを切り替える
```
git checkout <既存ブランチ名>
git checkout feature

# ブランチを新規作成して切り替える
git checkout -b <新ブランチ名>
```
### 変更履歴をマージする
```
git merge <ブランチ名>
git merge <リモート名/ブランチ名>
git merge origin/master
```
### ブランチを変更・削除する
```
# 変更する
git branch -m <ブランチ名>
git branch -m new_branch

# 削除する
git branch -d <ブランチ名>
git branch -d feature

# 強制削除する
git branch -D <ブランチ名>
```
## リベースのコマンド

### リベースで履歴を整えた形で変更を統合する
```
git rebase <ブランチ名>
```
### プルのリベース型
```
git pull --rebase <リモート名> <ブランチ名>
git pull --rebase origin master
```
### プルをリベース型に設定する
```
git config --global pull.rebase true

# masterブランチでgit pullする時だけ
git config branch.master.rebase true
```
### 複数のコミットをやり直す
```
git rebase -i <コミットID>
git rebase -i HEAD~3

pick gh21f6d ヘッダー修正
pick 193054e ファイル追加
pick 84gha0d README修正

# やり直したいcommitをeditにする
edit gh21f6d ヘッダー修正
pick 193054e ファイル追加
pick 84gha0d README修正

# やり直したら実行する
git commit --amend

# 次のコミットへ進む(リベース完了)
git rebase --continue
```
### コミットを並び替える、削除する
```
git rebase -i HEAD~3

pick gh21f6d ヘッダー修正
pick 193054e ファイル追加
pick 84gha0d README修正

# ①184gha0dのコミットを消す
# ②2193054eを先に適用する
pick 193054e ファイル追加
pick gh21f6d ヘッダー修正
```
### コミットをまとめる
```
git rebase -i HEAD~3

pick gh21f6d ヘッダー修正
pick 193054e ファイル追加
pick 84gha0d README修正

# コミットを1つにまとめる
pick gh21f6d ヘッダー修正
squash 193054e ファイル追加
squash 84gha0d README修正 # squashを指定すると直前のコミットと1つにできる。
```
### コミットを分割する
```
git rebase -i HEAD~3

pick gh21f6d ヘッダー修正
pick 193054e ファイル追加
pick 41gha0d READMEとindex修正

# コミットを分割する
pick gh21f6d ヘッダー修正
pick 193054e ファイル追加
edit 84gha0d READMEとindex修正

git reset HEAD^
git add README
git commit -m 'README修正'
git add index.html
git commit -m 'index.html修正'
git rebase --continue
```
## タグ付けのコマンド

### タグの一覧を表示する
```
git tag

# パターンを指定してタグを表示
git tag -l "201705"
20170501_01
20170501_02
20170503_01
```
### タグを作成する(注釈付きタグ)
```
git tag -a [タグ名] -m "[メッセージ]"
git tag -a 20170520_01 -m "version 20170520_01"
```
### タグを作成する(軽量版タグ)
```
git tag [タグ名]
git tag 20170520_01

# 後からタグ付けする
git tag [タグ名] [コミット名]
git tag 20170520_01 8a6cbc4
```
### タグのデータを表示する
```
git show [タグ名]
git show 20170520_01
```
### タグをリモートリポジトリに送信する
```
git push [リモート名] [タグ名]
git push origin 20170520_01

# タグを一斉に送信する
git push origin --tags
```
## スタッシュのコマンド

### 作業を一次避難する
```
git stash
git stash save
```
### 避難した作業を確認する
```
git stash list
```
### 避難した作業を復元する
```
# 最新の作業を復元する
git stash apply

# ステージの状況も復元する
git stash apply --index

# 特定の作業を復元する
git stash apply [スタッシュ名]
git stash apply stash@{1}
```
### 避難した作業を削除する
```
# 最新の作業を削除する
git stash drop

# 特定の作業を削除する
git stash drop [スタッシュ名]
git stash drop stash@{1}

# 全作業を削除する
git stash clear
```
## 最後に

Git、GitHubの超基礎入門でした。

 参考
[Git： もう怖くないGit！チーム開発で必要なGitを完全マスター](https://click.linksynergy.com/deeplink?id=j5IiBfvcKwo&mid=47984&murl=http%3A%2F%2Fhttps%3A%2F%2Fwww.udemy.com%2Fcourse%2Funscared_git%2F%3FcouponCode%3DST6MT42324)
