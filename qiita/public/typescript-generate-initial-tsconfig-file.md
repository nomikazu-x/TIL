---
title: TypeScriptプロジェクトにtsconfig.jsonを生成する方法
private: false
tags:
  - TypeScript
  - tsconfig
updated_at: '2024-08-10T00:30:55.111Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

### TypeScriptプロジェクトに`tsconfig.json`を生成する方法

TypeScriptプロジェクトを始める際に、TypeScriptコンパイラの設定を行うための`tsconfig.json`ファイルが必要です。このファイルは、プロジェクトのコンパイル設定やエクスポートするJavaScriptのバージョンなどを定義します。この記事では、`tsconfig.json`ファイルを簡単に生成する方法を説明します。

#### TypeScriptをプロジェクトにインストールする

まず最初に、プロジェクトにTypeScriptをインストールする必要があります。TypeScriptは`typescript`というパッケージとして提供されており、`npm`を使ってインストールします。開発環境用の依存関係としてインストールするため、以下のコマンドを実行してください。

```bash
$ npm install typescript --save-dev
```

これで、プロジェクトにTypeScriptがインストールされ、`node_modules`フォルダ内に`tsc`コマンドが利用可能になります。

#### `package.json`に`tsc`スクリプトを追加する

次に、`tsc`コマンドを簡単に実行できるようにするため、`package.json`ファイルに`tsc`スクリプトを追加します。これにより、プロジェクト内で`npm run tsc`を実行するだけで、TypeScriptのコンパイラを使用できるようになります。

`package.json`の`scripts`セクションに以下の行を追加します。

```json
"scripts": {
  "tsc": "tsc"
}
```

この設定により、`npm run tsc`コマンドが、プロジェクト内でTypeScriptコンパイラを実行するためのスクリプトとして機能します。

#### `tsconfig.json`ファイルを生成する

最後に、`tsconfig.json`ファイルを生成します。これには、`npm`を使って以下のコマンドを実行します。

```bash
$ npm run tsc -- --init
```

コマンド内の`--`は、`npm`に対して、続く引数を`tsc`コマンドに渡すよう指示するために使用します。これにより、`--init`が`tsc`コマンドに渡され、`tsconfig.json`ファイルが生成されます。

生成された`tsconfig.json`ファイルは、多くのコメントと共に設定オプションが記載されたファイルとなります。初期状態では、ほとんどのオプションがコメントアウトされていますが、プロジェクトのニーズに応じてこれらのオプションを有効にすることができます。

```json
{
  "compilerOptions": {
    /* このファイルについて詳しくは https://www.typescriptlang.org/tsconfig/ を参照してください */

    /* プロジェクト設定 */
    // "incremental": true, /* プロジェクトのインクリメンタルコンパイルを可能にするため、.tsbuildinfoファイルを保存します。 */
    /* ... */

    /* 言語と環境設定 */
    "target": "es2020", /* 出力されるJavaScriptのバージョンを設定し、対応するライブラリの宣言を含めます。 */
    /* ... */
  }
}
```

以上で、`tsconfig.json`ファイルの初期設定が完了しました。これで、プロジェクトでのTypeScriptの使用が可能になり、必要に応じて設定をカスタマイズすることができます。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P
