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


## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる限定の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://bit.ly/3xLrLGw