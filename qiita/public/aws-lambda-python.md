---
title: PythonをLambda関数としてデプロイする方法
private: false
tags:
  - AWS
  - Lambda
  - Python
updated_at: '2024-07-07T11:00:09.263Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

この方法を模索してきましたが、ついにすべてのピースを組み合わせることができました。

[AWS Lambda](https://aws.amazon.com/lambda/)は、Pythonで書かれた関数をホストすることができます。これは「ゼロスケール」- 私の大好きなサーバーレスの定義です！- つまり、実際にトラフィックが発生した場合にのみ料金が発生し、トラフィックがないプロジェクトは運用コストがかかりません。

以前は、これらの関数をトリガーする動作するURLを取得するために多くの追加手順が必要でしたが、Lambda Function URLsがリリースされ、そのプロセスが劇的に簡素化されました。

それでもなお、まだ多くのステップがあります。ここでは、PythonウェブアプリケーションをLambda関数としてデプロイする方法を紹介します。

## AWS CLIツールの設定

これを行ったのはずいぶん前のことで、方法を覚えていません。AWSアカウントが必要で、[AWS CLIツール](https://aws.amazon.com/cli/)をインストールして設定する必要があります。

`aws --version`コマンドは、バージョン番号`1.22.90`以上を返すべきです。というのも、そのバージョンで関数URLサポートが追加されたためです。

私のツールのバージョンが古すぎたため、以下の方法でアップグレードする方法を見つけました：

```bash
head -n 1 $(which aws)
```
出力:
```
#!/usr/local/opt/python@3.9/bin/python3.9
```
これにより、ツールが含まれているPython環境の場所が分かります。そのパスを編集して次のようにアップグレードしました：
```bash
/usr/local/opt/python@3.9/bin/pip3 install -U awscli
```

## Pythonハンドラー関数の作成

以下は、Pythonハンドラー関数としての「Hello World」です。これを`lambda_function.py`に入れます：

```python
def lambda_handler(event, context): 
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/html"
        },
        "body": "<h1>Hello World from Python</h1>"
    }
```

## ZIPファイルに追加

これは最も直感的でない部分です。Lambda関数はZIPファイルとしてデプロイされます。このZIPファイルには、Pythonコードとそのすべての依存関係が含まれている必要があります - その詳細は後述します。

最初の関数には依存関係がないので、はるかに簡単です。以下のようにしてZIPファイルに変換し、デプロイの準備をします：
```bash
zip function.zip lambda_function.py
```

## ポリシーを持つロールの作成

Lambda関数を初めてデプロイする際にのみこれを行う必要があります。他の手順に使用できるIAMロールが必要です。

このコマンドは、`lambda-ex`という名前のロールを作成します：
```
aws iam create-role \
  --role-name lambda-ex \
  --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"}
    ]}'
```
次にこれを実行する必要があります。なぜこれが`create-role`コマンドの一部として処理できないのか分かりませんが、必要です：
```
aws iam attach-role-policy \
  --role-name lambda-ex \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
```

## AWSアカウントIDの取得

次のステップに必要なAWSアカウントIDを確認する必要があります。

以下のコマンドを実行して確認します：
```bash
aws sts get-caller-identity \
  --query "Account" --output text
```
これを環境変数に割り当てて後で使用するようにします：
```bash
export AWS_ACCOUNT_ID=$(
  aws sts get-caller-identity \
  --query "Account" --output text
)
```
これが機能するか確認するために以下を実行します：
```bash
echo $AWS_ACCOUNT_ID
```

## 関数のデプロイ

今、ZIPファイルを新しいLambda関数としてデプロイできます！

一意の関数名を選択します - 私は`lambda-python-hello-world`を選びました。

次に以下を実行します：
```bash
aws lambda create-function \
  --function-name lambda-python-hello-world \
  --zip-file fileb://function.zip \
  --runtime python3.9 \
  --handler "lambda_function.lambda_handler" \
  --role "arn:aws:iam::${AWS_ACCOUNT_ID}:role/lambda-ex"
```
ここでは、`function.zip`ファイルを`python3.9`ランタイムを使用してデプロイするよう指定しています。

Pythonファイルが`lambda_function.py`と呼ばれ、関数が`lambda_handler`と呼ばれていたため、`lambda_function.lambda_handler`をハンドラーとしてリストしています。

すべてが順調に行けば、以下のような応答が返されるはずです：

```json
{
    "FunctionName": "lambda-python-hello-world",
    "FunctionArn": "arn:aws:lambda:us-east-1:123456789012:function:lambda-python-hello-world",
    "Runtime": "python3.9",
    "Role": "arn:aws:iam::123456789012:role/lambda-ex",
    "Handler": "lambda_function.lambda_handler",
    "CodeSize": 332,
    "Description": "",
    "Timeout": 3,
    "MemorySize": 128,
    "LastModified": "2023-09-19T02:27:18.213+0000",
    "CodeSha256": "Y1nCZLN6KvU9vUmhHAgcAkYfvgu6uBhmdGVprq8c97Y=",
    "Version": "$LATEST",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "316481f5-7934-4e54-914f-6b075bb7d9dd",
    "State": "Pending",
    "StateReason": "The function is being created.",
    "StateReasonCode": "Creating",
    "PackageType": "Zip",
    "Architectures": [
        "x86_64"
    ],
    "EphemeralStorage": {
        "Size": 512
    }
}
```

## 実行許可の付与

すべてが動作するために必要なこの魔法のコマンドも実行します：

```bash
aws lambda add-permission \
  --function-name lambda-python-hello-world \
  --action lambda:InvokeFunctionUrl \
  --principal "*" \
  --function-url-auth-type "NONE" \
  --statement-id url
```

## 関数にURLを付与

ブラウザで関数をトリガーするためのURLが必要です。

以下のようにして、デプロイされた関数に新しい関数URLを追加します：

```
aws lambda create-function-url-config \
  --function-name lambda-python-hello-world \
  --auth-type NONE
```

この`--auth-type NONE`は、インターネット上の誰でもURLにアクセスして関数をトリガーできることを意味します。

これにより、以下のような結果が返されるはずです：

```json
{
    "FunctionUrl": "https://example-lambda-url.lambda-url.us-east-1.on.aws/",
    "FunctionArn": "arn:aws:lambda:us-east-1:123456789012:function:lambda-python-hello-world",
    "AuthType": "NONE",
    "CreationTime": "2023-09-19T02:27:48.356967Z"
}
```
確かに、https://example-lambda-url.lambda-url.us-east-1.on.aws/ にアクセスすると「Hello World from Python」が表示されます。

## 関数の更新

関数をデプロイした後、更新するのは非常に簡単です。

新しい`function.zip`ファイルを作成します - 私はこのようにします：

```bash
rm -f function.zip # 既に存在する場合は削除
zip function.zip lambda_function.py 
```
次に、以下のようにして更新をデプロイします：
```bash
aws lambda update-function-code \
  --function-name lambda-python-hello-world \
  --zip-file fileb://function.zip
```



## 純粋なPython依存関係の追加

プロジェクトに依存関係を追加することは、このプロセス全体で最も混乱する部分でした。

最終的に、良い方法を見つけました。これは、PixegamiのYouTubeビデオに付随する例コードとして公開されていました。

コツは、すべての依存関係をZIPファイルのルートに含めることです。

`requirements.txt`などは無視します。実際の依存関係のコピーをインストールする必要があります。

私にとってうまくいったレシピは次のとおりです。まず、依存関係をリストした`requirements.txt`ファイルを作成します：

```
cowsay
```

次に、`pip install -t`コマンドを使用してこれらの依存関係を特定のディレクトリにインストールします - 私は`lib`を使用します：
```bash
python3 -m pip install -t lib -r requirements.txt
```
`lib`にファイルがあることを確認するために`ls -lah lib`を実行します。
```
ls lib | cat
```
```
bin
cowsay
cowsay-5.0-py3.10.egg-info
```
次に、このレシピを使用して`lib`内のすべてをZIPファイルのルートに追加します：
```bash
(cd lib; zip ../function.zip -r .)
```
このコマンドを実行してZIPファイル内のファイルリストを確認できます：
```bash
unzip -l function.zip
```

`lambda_function.py`を更新して`cowsay`ライブラリを示します：
```python
import cowsay


def lambda_handler(event, context): 
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/plain"
        },
        "body": cowsay.get_output_string("pig", "Hello world, I am a pig")
    }
```
更新した`lambda_function.py`を再びZIPファイルに追加します：
```bash
zip function.zip lambda_function.py
```
更新をデプロイします：
```
aws lambda update-function-code \
  --function-name lambda-python-hello-world \
  --zip-file fileb://function.zip
```
先ほどのURLをリフレッシュすると、次のようになります：
```
  _______________________
| Hello world, I am a pig |
  =======================
                       \
                        \
                         \
                          \
                                    ,.
                                   (_|,.
                                   ,' /, )_______   _
                               __j o``-'        `.'-)'
                               (")                 \'
                               `-j                |
                                 `-._(           /
                                    |_\  |--^.  /
                                   /_]'|_| /_)_/
                                       /_]'  /_]'
```

## 高度なPython依存関係

上記のレシピは、純粋にPythonで書かれた依存関係には問題なく動作します。

より複雑になるのは、ネイティブコードを含む依存関係を使用したい場合です。

私はMacを使用しています。`pip install -t lib -r requirements.txt`を実行すると、これらの依存関係のMacバージョンが取得されます。

しかし、AWS Lambda関数はAmazon Linuxで実行されます。そのため、Amazon Linux用にビルドされたパッケージをZIPファイルに含める必要があります。

初めてこの問題に直面したのは、`python3.9`ランタイムが非常に古いSQLiteバージョンを含んでいることに気づいたときでした - 2013年5月20日のバージョン3.7.17です。

[pysqlite3-binary](https://pypi.org/project/pysqlite3-binary/)パッケージは、より新しいSQLiteを提供し、[Datasette](https://datasette.io/)はそれがインストールされている場合自動的にそれを使用します。

これを行う最善の方法は、Amazon Linux Dockerコンテナ内で`pip install`コマンドを実行することだと判断しました。多くの試行錯誤の末、次のようにするレシピを考え出しました：
```bash
docker run -t -v $(pwd):/mnt \
  public.ecr.aws/sam/build-python3.9:latest \
  /bin/sh -c "pip install -r /mnt/requirements.txt -t /mnt/lib"
```

- `-v $(pwd):/mnt`フラグは現在のディレクトリをコンテナ内の`/mnt`としてマウントします。
- `public.ecr.aws/sam/build-python3.9:latest`イメージは公式のAWS Lambda Python 3.9イメージです。
- `/bin/sh -c "pip install -r /mnt/requirements.txt -t /mnt/lib"`はコンテナ内で`pip install`を実行しますが、ファイルは`lib`フォルダに書き込まれるようにします。

このレシピは機能します！結果はAmazon Linux Pythonパッケージでいっぱいの`lib/`フォルダであり、これをZIPしてデプロイする準備が整います。

## ASGIアプリケーションの実行

私は[Datasette](https://datasette.io/)をデプロイしたいと思っています。

Datasetteは[ASGIアプリケーション](https://simonwillison.net/2019/Jun/23/datasette-asgi/)です。

しかし、AWS Lambda関数にはHTTPに対する独自のインターフェースがあり、上記の`event`と`context`パラメータがそれを示しています。

[Mangum](https://github.com/jordaneremieff/mangum)は、このギャップを埋めるよく知られたライブラリです。

以下は、DatasetteとMangumを動作させる方法です。驚くほど簡単でした！

`requirements.txt`ファイルに以下を追加しました：

```
datasette
pysqlite3-binary
mangum
```
`lib`フォルダを削除しました：
```
rm -rf lib
```
次に上記の魔法の呪文を実行しました：

```bash
docker run -t -v $(pwd):/mnt \
  public.ecr.aws/sam/build-python3.9:latest \
  /bin/sh -c "pip install -r /mnt/requirements.txt -t /mnt/lib"
```
依存関係を新しい`function.zip`ファイルに追加しました：
```bash
rm -rf function.zip
(cd lib; zip ../function.zip -r .)
```
次に`lambda_function.py`に以下を追加しました：
```python
import asyncio
from datasette.app import Datasette
import mangum


ds = Datasette(["fixtures.db"])
# Handler wraps the Datasette ASGI app with Mangum:
lambda_handler = mangum.Mangum(ds.app())
```
それをZIPファイルに追加しました：
```
zip function.zip lambda_function.py
```
最後に、標準のDatasette `fixtures.db`データベースファイルのコピーを取得し、それをZIPファイルに追加しました：

```bash
wget https://latest.datasette.io/fixtures.db
zip function.zip fixtures.db
```
完成した`function.zip`は7.1MBです。デプロイします：
```
aws lambda update-function-code \
  --function-name lambda-python-hello-world \
  --zip-file fileb://function.zip
```
これでうまくいきました！Lambda上でDatasetteインスタンスが稼働しています：https://example-lambda-url.lambda-url.us-east-1.on.aws/

デフォルトのLambda構成では128MBのRAMしか提供されておらず、時折タイムアウトエラーが発生しました。256MBに増やすことで問題が解決しました：

```bash
aws lambda update-function-configuration \
  --function-name lambda-python-hello-world \
  --memory-size 256
```

## StarletteやFastAPIにも対応可能

MangumはASGIアプリに対応しているため、[Starlette](https://www.starlette.io/)や[FastAPI](https://fastapi.tiangolo.com/)で作成されたアプリも同様に動作します。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる限定の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://bit.ly/3xLrLGw