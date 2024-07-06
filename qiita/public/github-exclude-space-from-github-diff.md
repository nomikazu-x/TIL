---
title: GitHubの差分から空白のみの変更を除外して確認する方法
tags:
  - Git
  - GitHub
  - 基礎
private: false
updated_at: '2024-07-06T20:00:43+09:00'
id: ff8e8069a6777379dfb5
organization_url_name: null
slide: false
ignorePublish: false
---

もし、きちんと整った開発環境を保ち、Lintツールなどのプラグインを駆使しているなら、空白の変更がgitの差分を乱すことはあまり問題にならないかと思います。

しかし、他の人と一緒に作業していたり、整理されていないコードベースで作業している場合は、そう上手くも行かないかもしれません。コミットにたくさんの空白のみの変更が含まれていると、GitHubの差分ビューが煩雑で読みづらくなることがあります。。。


## 確認方法
GitHubの差分ビューのリンクに`w=1`を追加することで、空白の変更を除外して差分を表示できます！

**例：コミットログ**
- 通常の差分ビュー：
https://github.com/user-name/project-name/commit/commit-hash
- 空白を除外した差分ビュー：
https://github.com/user-name/project-name/commit/commit-hash?**w=1**

## まとめ
`w=1`を活用し、空白の変更を除外することで、よりスッキリした差分を確認できます！ぜひ活用してみてください！

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる限定の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://bit.ly/3xLrLGw
