---
title: zshでHeredoc構文を使ってコマンド引数を渡す方法
emoji: 💡
type: tech
topics: 
  - zsh
  - bash
  - Terminal
published: true
---

## 実現したいこと

以下の内容をsqlite-utils CLIツールに引数として渡したい。

```bash
insert into documents select
  substr(s3_ocr_etag, 1, 4) as id,
  key as title,
  key as path,
  replace(s3_ocr_etag, '"', '') as etag
from
  index2.ocr_jobs;
```

## 問題点
この中にはシングルクオートとダブルクオートの両方が含まれているため、文字列のエスケープが少し厄介です。。。

## 解決策
Heredoc構文を使います（Bashとzshの両方で可）

```bash
sqlite-utils sfms.db --attach index2 index.db "$(cat <<EOF
insert into documents select
  substr(s3_ocr_etag, 1, 4) as id,
  key as title,
  key as path,
  replace(s3_ocr_etag, '"', '') as etag
from
  index2.ocr_jobs;
EOF
)"
```

これを分解すると、主なポイントは`cat <<EOF ... EOF`を使ってリテラルのテキストを包むことです：
```bash
$(cat <<EOF
insert into documents select
  substr(s3_ocr_etag, 1, 4) as id,
  key as title,
  key as path,
  replace(s3_ocr_etag, '"', '') as etag
from
  index2.ocr_jobs;
EOF
)
```

そして、これを`sqlite-utils`コマンドの引数として渡すために、`"$(cat ...)"`を使います。この`"`があることで、zshやbashがその入力内のトークンを別々の引数として扱わないようにしています。
