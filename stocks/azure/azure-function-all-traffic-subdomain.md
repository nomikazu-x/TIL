---
title: AzureFunctionを使用してサブドメインへのすべてのトラフィックを処理する方法
emoji: 🤖
type: tech # tech: 技術記事 / idea: アイデア
topics: 
  - Azure
  - AzureFunction
published: true
---

[Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/)は、デフォルトで`/api/FunctionName`のようなパスからトラフィックを処理します。例えば、`https://your-subdomain.azurewebsites.net/api/MyFunction`というURLです。

サブドメイン全体のトラフィックを単一の関数で処理したい場合（例えば、[Datasette](https://datasette.io/)を使用する場合）、その関数がサブドメインへのすべてのトラフィックをキャプチャする必要があります。

ここでは、`https://your-subdomain.azurewebsites.net/`以下の任意のパスに対するすべてのトラフィックをキャプチャする方法を説明します。


## 1. host.jsonを更新する
まず、`host.json`ファイルに次のセクションを追加します。

```json:host.json
{
    "extensions": {
        "http": {
            "routePrefix": ""
        }
    }
}
```

## 2. function.jsonを更新する
次に、すべてのトラフィックを処理したい関数の`function.json`ファイルに`"route": "{*route}"`を追加します。

**例：**

```json:function.json
{
    "scriptFile": "__init__.py",
    "bindings": [
        {
            "authLevel": "Anonymous",
            "type": "httpTrigger",
            "direction": "in",
            "name": "req",
            "route": "{*route}",
            "methods": [
                "get",
                "post"
            ]
        },
        {
            "type": "http",
            "direction": "out",
            "name": "$return"
        }
    ]
}
```
