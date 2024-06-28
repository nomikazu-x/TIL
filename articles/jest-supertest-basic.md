---
title: 【初心者向け】JavaScriptテスト完全ガイド：JestとSupertestで始める7つのステップ
emoji: 🤖
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - JavaScript
  - Jest
  - Supertest
published: true
---

## 1. はじめに

### 目的
この記事の目的は、JavaScriptでテストを簡単に行うための方法を示すことです。特に、JestとSupertestという二つの強力なツールを使用して、テストの基本から応用までをステップバイステップで解説します。これにより、開発者がより効率的に、そして自信を持ってコードをリリースできるようになることを目指しています。

### 対象読者
この記事は、主にJavaScriptを使用してウェブアプリケーションを開発している開発者を対象としています。特に、Node.jsとExpressフレームワークを使用している開発者にとって有益です。初心者から中級者まで、幅広いレベルの開発者が対象です。

### なぜJestとSupertestを使うのか？
JestとSupertestは、JavaScriptのテストを効率化し、信頼性を向上させるための強力なツールです。以下の理由から、これらのツールを選択する価値があります：

- **Jest**：
  - **オールインワン**：Jestは、テストランナー、アサーションライブラリ、モッキングライブラリを一体化したオールインワンのテストフレームワークです。
  - **シンプルな設定**：設定が簡単で、迅速にテスト環境を整えることができます。
  - **スナップショットテスト**：コンポーネントのレンダリング結果を保存し、後で比較するスナップショットテスト機能を提供します。

- **Supertest**：
  - **HTTPリクエストのシミュレーション**：Supertestは、ExpressなどのNode.jsアプリケーションに対するHTTPリクエストをシミュレートするためのツールです;。
  - **統合テストの簡便化**：統合テストを容易にし、エンドポイントの動作を詳細に確認できます。

これらのツールを使用することで、開発者は自信を持ってコードをリリースし、バグのない安定したアプリケーションを提供することができます。

## 2. JestとSupertestの概要

### Jestの紹介
Jestは、Facebookによって開発されたJavaScriptのテストフレームワークです。以下の特徴と利点があります：

- **オールインワン**：Jestはテストランナー、アサーションライブラリ、モッキングライブラリを一体化したオールインワンのテストフレームワークです。これにより、追加の設定やツールを導入する必要がなく、シンプルにテストを開始できます。
- **スナップショットテスト**：Jestはスナップショットテスト機能を提供します。これは、コンポーネントのレンダリング結果をスナップショットとして保存し、後で比較する機能です。UIの変更が意図したものであるかを確認するのに非常に便利です。
- **クロスプラットフォーム対応**：Jestはクロスプラットフォームで動作し、様々な環境でテストを実行することができます。
- **高速な実行**：Jestは、並列テスト実行やスマートなキャッシュ機能を備えており、大規模なプロジェクトでも高速にテストを実行できます。

### Supertestの紹介
Supertestは、Node.jsのHTTPアサーションライブラリであり、Expressなどのウェブアプリケーションの統合テストに非常に役立ちます。

- **HTTPリクエストのシミュレーション**：Supertestは、実際のHTTPリクエストをシミュレートすることで、サーバーのエンドポイントをテストできます。これにより、クライアントとサーバー間の通信を詳細にテストすることが可能です。
- **シンプルなインターフェース**：SupertestのAPIはシンプルで直感的であり、リクエストの作成とレスポンスのアサーションを容易に行うことができます。
- **Expressとの統合**：Supertestは、Expressアプリケーションと特に相性が良く、Expressのミドルウェアやルーティングを簡単にテストすることができます。

### なぜこれらのツールを使用するのか？
- **統合テストの簡便さ**：JestとSupertestを組み合わせることで、ユニットテストだけでなく、統合テストやエンドツーエンドテストも容易に行うことができます。これにより、アプリケーション全体の信頼性を高めることができます。
- **強力なモッキング機能**：Jestのモッキング機能を使用することで、外部サービスやデータベースの依存をモックし、テストの独立性を保つことができます。これにより、テストが他の要因に影響されることなく、一貫して実行できます。

## 3. 環境設定

### インストール方法
JestとSupertestを使用してテスト環境を設定するための手順は以下の通りです：

1. **プロジェクトのセットアップ**：
    プロジェクトディレクトリに移動し、Node.jsのプロジェクトを初期化します。
    ```bash
    npm init -y
    ```

2. **JestとSupertestのインストール**：
    JestとSupertestを開発依存関係としてインストールします。
    ```bash
    npm install --save-dev jest supertest
    ```

3. **Jestの設定ファイルを作成**：
    プロジェクトのルートディレクトリに`jest.config.js`というファイルを作成し、以下のように設定します。
    ```javascript:jest.config.js
    module.exports = {
      testEnvironment: 'node',
      verbose: true,
    };
    ```

    - `testEnvironment: 'node'`：デフォルトの`jsdom`ではなく、Node.jsの環境でテストを実行する設定です。
    - `verbose: true`：詳細なテスト結果を表示するオプションです。

### 基本的な設定
次に、テストの実行をサポートするためのディレクトリ構造と設定を行います。

1. **ディレクトリ構造の作成**：
    テスト用のディレクトリを作成し、各テストケースを整理します。
    ```bash
    mkdir tests
    ```

2. **テストスクリプトの追加**：
    `package.json`にテストスクリプトを追加します。
    ```json:package.json
    "scripts": {
      "test": "jest"
    }
    ```

3. **サンプルテストの作成**：
    テストディレクトリにサンプルテストファイルを作成します。例えば、`tests/sample.test.js`として以下の内容を追加します。
    ```javascript:tests/sample.test.js
    const request = require('supertest');
    const express = require('express');

    const app = express();

    app.get('/test', (req, res) => {
      res.status(200).send({ message: 'Hello, world!' });
    });

    test('GET /test', async () => {
      const response = await request(app).get('/test');
      expect(response.statusCode).toBe(200);
      expect(response.body.message).toBe('Hello, world!');
    });
    ```

    - このサンプルテストは、Expressアプリケーションの簡単なエンドポイントをテストします。
    - `request(app).get('/test')`を使って、Supertestがエンドポイントへのリクエストをシミュレートし、レスポンスを確認します。

### 設定の確認と実行
上記の設定が完了したら、Jestを使用してテストを実行します。

**テストの実行**：
    ```bash
    npm test
    ```

    - このコマンドを実行すると、Jestが`tests`ディレクトリ内のテストファイルを自動的に検出し、テストを実行します。

以上で、基本的なテスト環境の設定が完了です。
次のセクションでは、実際にテストケースを記述し、ユニットテスト、モジュールのモック、非同期コードのテスト方法について詳しく説明します。

## 4. 基本的なテストの書き方
ユニットテスト
ユニットテストは、個々の関数やモジュールが期待通りに動作するかを確認するための基本的なテストです。Jestを使用すると、シンプルかつ効率的にユニットテストを作成できます。

以下に、単純な関数をテストする例を示します。

**テスト対象の関数** (sum.js)

```javascript:sum.js
function sum(a, b) {
  return a + b;
}
module.exports = sum;
```

**ユニットテスト** (sum.test.js)

```javascript:sum.test.js
const sum = require('./sum');

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});
```

test関数は、個々のテストケースを定義します。
expect関数は、実際の値と期待される値を比較します。
モジュールのモック
Jestのモック機能を使用すると、外部モジュールや依存関係を簡単にモックできます。これにより、テスト対象のコードが特定の条件下でどのように動作するかを確認できます。

**モジュールのモックの例** (fetchData.js)

```javascript:fetchData.js
const axios = require('axios');

async function fetchData(url) {
  const response = await axios.get(url);
  return response.data;
}
module.exports = fetchData;
```

**モックを使用したテスト** (fetchData.test.js)

```javascript:fetchData.test.js
const fetchData = require('./fetchData');
const axios = require('axios');
jest.mock('axios');

test('fetches successfully data from an API', async () => {
  const data = { name: 'John Doe' };
  axios.get.mockResolvedValue({ data });

  const result = await fetchData('https://api.example.com/user');
  expect(result).toEqual(data);
});
```

jest.mock('axios')を使用して、axiosモジュールをモックします。
axios.get.mockResolvedValueを使って、axiosのgetメソッドが特定の値を返すように設定します​​。
非同期コードのテスト
非同期関数のテストもJestでは非常に簡単です。async/awaitを使用して、非同期コードのテストを直感的に書くことができます。

**非同期関数のテストの例** (asyncFunction.js)

```javascript:asyncFunction.js
async function fetchData() {
  return 'Hello, world!';
}
module.exports = fetchData;
```

**非同期関数のテスト** (asyncFunction.test.js)

```javascript:asyncFunction.test.js
const fetchData = require('./asyncFunction');

test('fetches data', async () => {
  const data = await fetchData();
  expect(data).toBe('Hello, world!');
});
```

非同期関数をテストするために、test関数にasyncを付け、非同期関数の結果を待機 (await) します。
非同期関数の結果が期待される値と一致するかを確認します​。
次のセクションでは、Expressアプリケーションのテストについて詳しく説明します。具体的なAPIエンドポイントのテスト方法やモックデータベースの使用方法を見ていきましょう。

## 5. Expressアプリケーションのテスト
APIエンドポイントのテスト
Supertestを使うことで、ExpressアプリケーションのAPIエンドポイントをテストするのが非常に簡単になります。以下に、GET、POST、PUT、DELETEリクエストをテストする具体例を示します。

**アプリケーション設定** (app.js)

```javascript:app.js
const express = require('express');
const app = express();

app.use(express.json());

app.get('/user', (req, res) => {
  res.status(200).send({ name: 'John Doe' });
});

app.post('/user', (req, res) => {
  const user = req.body;
  res.status(201).send(user);
});

app.put('/user/:id', (req, res) => {
  const { id } = req.params;
  const user = req.body;
  res.status(200).send({ id, ...user });
});

app.delete('/user/:id', (req, res) => {
  const { id } = req.params;
  res.status(200).send({ id });
});

module.exports = app;
```

**テストファイル** (app.test.js)

```javascript:app.test.js
const request = require('supertest');
const app = require('./app');

describe('User API', () => {
  it('GET /user - success', async () => {
    const response = await request(app).get('/user');
    expect(response.statusCode).toBe(200);
    expect(response.body.name).toBe('John Doe');
  });

  it('POST /user - success', async () => {
    const newUser = { name: 'Jane Doe' };
    const response = await request(app).post('/user').send(newUser);
    expect(response.statusCode).toBe(201);
    expect(response.body.name).toBe('Jane Doe');
  });

  it('PUT /user/:id - success', async () => {
    const updatedUser = { name: 'Jane Doe Updated' };
    const response = await request(app).put('/user/1').send(updatedUser);
    expect(response.statusCode).toBe(200);
    expect(response.body.name).toBe('Jane Doe Updated');
  });

  it('DELETE /user/:id - success', async () => {
    const response = await request(app).delete('/user/1');
    expect(response.statusCode).toBe(200);
    expect(response.body.id).toBe('1');
  });
});
```

このテストコードでは、各HTTPメソッドのエンドポイントをテストしています。supertestを使用して、エンドポイントにリクエストを送り、レスポンスのステータスコードと内容を検証します​。

**モックデータベースの使用**
テスト環境でデータベースに依存することなく、モックデータベースを使用することで、テストの独立性を高めることができます。ここでは、MongoMemoryServerを使用してMongoDBをモックする方法を紹介します。

**モックデータベース設定** (bootstrap.js)

```javascript:bootstrap.js
const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');

let mongod;

beforeAll(async () => {
  mongod = await MongoMemoryServer.create();
  const uri = mongod.getUri();
  await mongoose.connect(uri);
});

afterAll(async () => {
  await mongoose.connection.dropDatabase();
  await mongoose.connection.close();
  await mongod.stop();
});

afterEach(async () => {
  const collections = mongoose.connection.collections;
  for (const key in collections) {
    const collection = collections[key];
    await collection.deleteMany();
  }
});
```

**テストファイル** (user.test.js)

```javascript:user.test.js
const request = require('supertest');
const app = require('../app');
const User = require('../models/user');

describe('User API with MongoMemoryServer', () => {
  it('should create a new user', async () => {
    const newUser = { name: 'Jane Doe' };
    const response = await request(app).post('/user').send(newUser);
    expect(response.status).toBe(201);
    expect(response.body.name).toBe('Jane Doe');
  });

  it('should get a user', async () => {
    const user = new User({ name: 'John Doe' });
    await user.save();

    const response = await request(app).get(`/user/${user._id}`);
    expect(response.status).toBe(200);
    expect(response.body.name).toBe('John Doe');
  });

  // 他のテストケースも追加可能
});
```

この方法では、MongoMemoryServerを使用してMongoDBのインスタンスをメモリ上に立ち上げ、テストデータを格納します。これにより、実際のデータベースを使用することなく、テストが可能になります​。

次のセクションでは、テストのベストプラクティスについて詳しく説明します。テストの整理、明確な命名、独立性の維持など、効果的なテスト戦略を見ていきましょう。

## 6. ベストプラクティス
効果的なテスト戦略を構築するためには、テストの整理、明確な命名、独立性の維持などのベストプラクティスを遵守することが重要です。以下に、具体的なベストプラクティスをいくつか紹介します。

**テストの整理**
テストを整理するための方法として、関連するテストをグループ化することが重要です。これにより、テストの可読性と保守性が向上します。

**describeブロックを使用したグループ化の例**

```javascript:user.test.js
describe('User Routes', () => {
  test('GET /users - success', async () => {
    // テストコード
  });

  test('POST /users - success', async () => {
    // テストコード
  });
});
```

describeブロックを使用することで、関連するテストケースを一つのグループとしてまとめることができます。これにより、テストレポートが見やすくなり、特定の機能に関連するすべてのテストを簡単に見つけることができます​。
明確な命名
テストケースには、何をテストしているのかを明確に示す名前を付けることが重要です。名前が具体的であればあるほど、テストの目的がわかりやすくなります。

**明確なテスト名の例**

```javascript:user.test.js
test('responds with 200 status and user data when valid ID is provided', async () => {
  // テストコード
});
```

テスト名は、そのテストが何を検証しているのかを明確に表現します。これにより、テストの内容を一目で理解することができます​。
テストの独立性
各テストケースは他のテストケースに依存しないように設計することが重要です。これにより、一つのテストが失敗しても他のテストに影響を与えることがなくなります。

**独立したテストの例**

```javascript:user.test.js
test('creates a new user', async () => {
  // 新しいユーザーを作成するテスト
});

test('updates an existing user', async () => {
  // 既存のユーザーを更新するテスト
});
```

各テストケースは独立して実行できるように設計されており、特定の順序で実行されることを前提としていません。これにより、テストの信頼性が向上します​​。
テストファイルの配置
テストファイルは、テスト対象のコードと同じディレクトリに配置するか、専用のテストディレクトリにまとめることが推奨されます。これにより、テストと実装コードを簡単に関連付けることができます。

**テストファイルの配置例**

routes/user.js のテストファイルを同じディレクトリに配置する場合：routes/user.test.js
すべてのテストを専用のディレクトリにまとめる場合：tests/routes/user.test.js
定期的なテストメンテナンス
テストコードも他のコードと同様にメンテナンスが必要です。アプリケーションの変更に応じてテストを更新し、古くなったテストを削除することが重要です。

**定期的なテストメンテナンスの例**

新機能が追加された場合、それに対応する新しいテストを作成します。
使用されなくなった機能に対するテストを削除し、テストコードを整理します。
これらのベストプラクティスを遵守することで、テストの信頼性と効率性が向上し、アプリケーションの品質を高めることができます​​。

次のセクションでは、テスト中に遭遇する一般的な問題とそのトラブルシューティング方法について詳しく説明します。

## 7. トラブルシューティング
JestとSupertestを使用してテストを実行する際、開発者はさまざまな問題に直面することがあります。ここでは、一般的な問題とその解決方法について説明します。

**タイムアウトの問題**
非同期テストでは、タイムアウトが頻繁に発生することがあります。これは、非同期操作が予期された時間内に完了しない場合に発生します。

**タイムアウトの解決策**
Jestのデフォルトのタイムアウトは5秒ですが、これを変更することができます。

```javascript:asyncFunction.test.js
test('async test with increased timeout', async () => {
  // 非同期テストのロジック
}, 10000); // タイムアウトを10秒に設定
```

この例では、テストのタイムアウトを10秒に設定しています。複雑な非同期操作の場合は、このようにしてタイムアウトを延長することができます​。
外部依存関係のモック
テストが外部サービスやAPIに依存している場合、これらをモックすることでテストの信頼性を向上させることができます。

**外部依存関係のモック例**

```javascript
jest.mock('axios');

const axios = require('axios');
const fetchData = require('./fetchData');

test('mocks an API call', async () => {
  const data = { name: 'John Doe' };
  axios.get.mockResolvedValue({ data });

  const result = await fetchData('https://api.example.com/user');
  expect(result).toEqual(data);
});
```

jest.mock('axios')を使用して、axiosモジュールをモックします。これにより、テスト中に実際のAPIコールが発生しなくなり、安定したテスト結果が得られます​。
環境変数の取り扱い
テスト中に環境変数が正しく設定されていないと、予期しない動作が発生することがあります。これを防ぐために、テスト用の環境変数を設定します。

**環境変数の設定例**

```javascript
process.env.NODE_ENV = 'test';

test('uses test environment', () => {
  expect(process.env.NODE_ENV).toBe('test');
});
```

テストの冒頭で環境変数を設定し、その環境でテストが実行されるようにします​。
データベース接続の問題
テスト中にデータベース接続の問題が発生することがあります。これには、接続のタイムアウトやデータの一貫性の問題が含まれます。

**データベース接続のトラブルシューティング**

```javascript
beforeAll(async () => {
  await mongoose.connect('mongodb://localhost/test', { useNewUrlParser: true, useUnifiedTopology: true });
});

afterAll(async () => {
  await mongoose.disconnect();
});

test('database connection test', async () => {
  const users = await User.find();
  expect(users.length).toBe(0);
});
```

テストの前後にデータベースの接続と切断を適切に行い、接続が安定していることを確認します​。
モックのクリアリング
複数のテストケースで同じモックが使用されていると、モックの状態が他のテストケースに影響を与えることがあります。各テストの後にモックをクリアすることで、これを防ぎます。

**モックのクリアリング例**

```javascript
afterEach(() => {
  jest.clearAllMocks();
});

test('first test', () => {
  // テストロジック
});

test('second test', () => {
  // テストロジック
});
```

jest.clearAllMocks()を使用して、各テストの後にすべてのモックをクリアします。これにより、テストが他のモックに影響されることなく独立して実行されます​。
これらのトラブルシューティングの方法を活用することで、JestとSupertestを使用したテストの安定性と信頼性を向上させることができます。次のセクションでは、記事のまとめと次のステップについて説明します。

## 8. まとめと次のステップ
まとめ
この記事では、JavaScriptのテストを簡単にするために、JestとSupertestを使用する方法について詳しく説明しました。

チームメンバーや他の開発者からフィードバックを受け取り、テストコードの改善に役立てましょう。
これらのステップを通じて、テストの知識を深め、実践的なスキルを磨いていきましょう。良いテストを作成することで、プロジェクト全体の品質を向上させることができます。
Happy Testing!

