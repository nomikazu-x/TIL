# Zenn Qiita Contents

- Zenn: https://zenn.dev/nomikazu_x
- Qiita: https://qiita.com/nomikazu_x


# コマンド
## 1. Zennで執筆
```
npx zenn new:article // 新規作成
npx zenn preview // プレビュー
```
http://localhost:8000/でプレビューしながら執筆

## 2. コンテンツをGitHubに保存、Zenn, Qiitaにアップ
```
sh upload.sh
```

# 参考
- qiita-cli：https://github.com/increments/qiita-cli
- GitHubリポジトリでZennのコンテンツを管理する：https://zenn.dev/zenn/articles/connect-to-github
- リポジトリ参考：https://zenn.dev/ot07/articles/zenn-qiita-article-centralized

# GitHub Actions(Qiita投稿) エラー集
Qiita-CLI で起きたエラーやミスをまとめていきます（随時更新）

# command error

### その1

```
> npx qiita preview
[Error: ENOENT: no such file or directory, open '/Users/user/.config/qiita-cli/credentials.json'] {
  errno: -2,
  code: 'ENOENT',
  syscall: 'open',
  path: '/Users/user/.config/qiita-cli/credentials.json'
}
エラーが発生しました (ENOENT: no such file or directory, open '/Users/user/.config/qiita-cli/credentials.json')
  バグの可能性がある場合は，Qiita Discussionsよりご報告いただけると幸いです
  https://github.com/increments/qiita-discussions
```

:::note info

### 解決策

ログインができていない
`npx qiita login`で[トークン発行ページ](https://qiita.com/settings/applications)で発行したトークンを貼り付け
:::



# npx qiita publish --all

### その1

```
> npx qiita publish -all
エラーが発生しました (unknown or unexpected option: -a)
  バグの可能性がある場合は，Qiita Discussionsよりご報告いただけると幸いです
  https://github.com/increments/qiita-discussions
```

::: note info

### 解決策

オプションの指定が間違っている

`npx qiita publish -**-**all`
:::

### その２

```
> npx qiita publish -all
QiitaForbiddenError: {"message":"Forbidden","type":"forbidden"}
    at QiitaApi.request
    ...
Qiita APIへのリクエストに失敗しました
  Qiitaのアクセストークンが正しいかご確認ください
```

:::note info

### 解決策

タグにスペースが含まれている
:::

### その３

```
> npx qiita publish --all
qiita_error: 内容がQiita上の記事より古い可能性があります
```

:::note info

### 解決策

古いと思われる記事の`updated_at`を空白('')にする
:::