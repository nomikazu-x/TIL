---
title: Bashで文字列をエスケープしたい！
private: false
tags:
  - Bash
  - Terminal
updated_at: '2024-07-08T11:00:11.485Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

## エスケープの方法
1. `#`コメントから始まるBashの行を入力
2. 次の行で`!:q`を実行

これにより、エスケープが適用された文字列を見ることができます。

## 例

```bash
bash-3.2$ # This string 'has single' "and double" quotes and a $
bash-3.2$ !:q
'# This string '\''has single'\'' "and double" quotes and a $'
bash: # This string 'has single' "and double" quotes and a $: command not found
```
## 仕組みの説明
- `!`文字はヒストリ機能のHISTORY EXPANSION(履歴の展開)を開始する
- `!string`は`string`で始まる最後のコマンドを生成
- `:q`は結果を引用符で囲む修飾子
- これは、`string`が`""`である場合の`!string`に相当し、直近のコマンドを生成

**つまり、`!!`と同じように動作します**

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる限定の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://bit.ly/3xLrLGw