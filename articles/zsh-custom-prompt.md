---
title: zshプロンプトのカスタマイズ
emoji: 🕶️
type: tech
topics: 
  - zsh
  - Terminal
published: true
---

## 実現したいこと
現在いるディレクトリをプロンプトに表示したいなと思い、`zsh`をカスタマイズしました。

    username@hostname ~ % 

設定すると次のようになります。

    ~ % cd /tmp
    /tmp % 

## 変更方法
`~/.zshrc`ファイルの先頭にこの行を追加することで実現しました！

    PROMPT='%1~ %# '