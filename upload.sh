#!/bin/bash

FILE=${1}

# ファイルのパスがarticles配下ではないまたはファイルが存在しない場合、処理をスキップ
if [[ ! $FILE =~ ^articles/ ]] || [[ ! -e $FILE ]]; then
    echo "Skip ztoq: $FILE"
    continue
fi

# .md拡張子を削除してファイル名を取得
FILENAME=$(basename $FILE .md)

# ファイル名と同じファイルがqiita/public配下に存在しない場合だけ、npx qiita newを実行
if [ ! -e "qiita/public/$FILENAME.md" ]; then
    echo "Create qiita/public/$FILENAME.md"
    cd ./qiita
    npx qiita new "$FILENAME"
    cd ../
fi

# ./node_modules/.bin/ts-node scripts/ztoq.ts "取得したファイルパス" qiita/public/"取得したファイル名.md"を実行
./node_modules/.bin/ts-node scripts/ztoq.ts "$FILE" "qiita/public/$FILENAME.md"
echo "Convert $FILE to qiita/public/$FILENAME.md"
