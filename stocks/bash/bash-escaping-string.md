---
title: Bashで文字列をエスケープしたい！
emoji: 💡
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - Bash
  - Terminal
published: true
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
