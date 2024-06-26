---
title: 徹底解説！SQLの超基礎入門
private: false
tags:
  - SQL
  - MySQL
  - PostgreSQL
  - SQLite
  - 基礎
updated_at: '2024-06-26T06:15:43.316Z'
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

## データベースとは何か

大量のデータを保存し、コンピュータから利用しやすいように加工したデータの集まり。
データベースを管理するコンピュータシステムをデータベースマネジメントシステム(DBMS) と呼ぶ。

### DBMSが必要な理由

テキストファイルやExcelでもデータの保存はできるが、

- 多人数でデータを共有するのに向かない
- 大量のデータを扱える形式になってない
- 読み書きを自動化するのにプログラミング技術が必要
- 万一の事故に対応できない

などのデメリットがある。DBMSはこれらすべてを解消できる。

### 主流のDBMS

#### リレーショナルデータベース(RDB)

列と行からなる２次元表の形式のデータベース、理解しやすい
SQLという言語で操作する。
他にもオブジェクトを保存したりxmlを保存したりするいろんな種類のデータベースがあるけどここでは割愛。

## データベースの構成

クライアント/サーバ(C/S)型のシステム構成が基本。DBを利用するクライアント、DBを読み書きするサーバからなる。

２次元表のことをテーブル、そのデータ項目を表す列をカラム、１件のデータを表す行をレコードという。SQL文にしたがって返されるデータは全てテーブルの形、テーブルの形にならないSQL文は実行できない。
行と列が交わる部分(セル)には１つのデータしか入らない。

## SQLの概要

SQL：RDBMSを操作するための言語。標準SQLという標準規格があるが、RDBMSによって方言がある。
ここではPostgreSQLを使うが、標準SQL準拠で学習する。
SQL文では基本的にキーワードとテーブル名や列名を組み合わせて構成する、キーワードとなる命令は３種類

#### DDL(Data Definition Language)

- データ定義言語、DBやテーブルの作成、削除などを行う
- CREATE : DBやテーブルを作成
- DROP : DBやテーブルを削除
- ALTER : DBやテーブル構成の変更

#### DML(Data Manipulation Language)

- データ操作言語、テーブルの検索、変更などを行う
- SELECT : テーブルから行を検索
- INSERT : テーブルに新規行を登録
- UPDATE : テーブルの行を更新
- DELETE : テーブルの行を削除

#### DCL(Data Control Language)

- データ制御言語、DBに対して行った変更を確定したり、消したりする。他にはDBのユーザ権限の変更なども行う。
- COMMIT : DBに対して行った変更を確定
- ROLLBACK : DBに対して行った変更を取り消す
- GRANT : ユーザに操作の権限を付与

- REVOKE : ユーザから権限を剥奪

### SQL文の基本的なルール

- 最後に「;」を付ける
- 大文字、小文字は区別されない
  - キーワードやテーブル名、列名はどちらでも良い。けど基本的にキーワードは大文字、テーブル名や列名は小文字推奨
- ただし、登録されているデータに関してはちゃんと区別される
- 定数の書き方には決まりがある
  - 文字列や日時などの定数はシングルクォーテーションで囲う。e.g.) 'abc'
- 単語は半角スペースか改行で区切る

## テーブルの作成

### DBの作成
```SQL
CREATE DATABASE <DB名>
e.g) CREATE DATABASE shop
```

### テーブルの作成

```SQL
CREATE TABLE <TABLE名>(
                      <列名1> <データ型> <この列の制約>,
                      <列名2> <データ型> <この列の制約>
                      .
                      .
                      .
                      );
```

e.g.)

```SQL
CREATE TABLE Shohin(
                    shohin_id CHAR(4) NOT NULL,
                    shohin_mei VARCHAR(100) NOT NULL,
                    shohin_bunrui VARCHAR(32) NOT NULL,
                    hanbai_tanka INTEGER,
                    shiire_tanka INTEGER,
                    torokubi DATE,
                    PRIMARY KEY (shohin_id)
                    );
```

### 命名ルール

- DB、テーブル、列などの名前には
  - 半角アルファベット
  - 半角数字
  - アンダーバー（_）
- 名前の最初の文字は半角アルファベット
- 名前は重複してはいけない

### データ型

- INTEGER
  - 整数を入れる型、小数は入れられない
- CHAR
  - 文字列を入れるのに使う型、*CHAR(100)*のように入れることができる文字列の最大長を入れる。
  - 固定長文字列で文字列が格納され、例えばCHAR(8)の列に'abc'を入れると、'abc '(半角スペース５つ)で格納される。
- VARCHAR
  - CHARと同じく文字列を扱うデータ型だが、可変長文字列で格納されるため、データはそのまま。
- DATE
  - 日付を入れるのに使うデータ型

CHAR型は社員番号や郵便番号などデータの桁数が決まっているもの、VARCHARは氏名や書籍名などデータの桁数が変動するものに指定する。

### 制約の設定

制約: 列に入れるデータに制限や条件を追加する機能
上で指定した*NOT NULL(項目が無記入ではいけない)*など
また、PRIMARY KEY (shohin_id)では、shohin_idに主キー制約を付与している。
主キー: １つの行を特定できる一意な値

## テーブルの削除、変更

### テーブルの削除
```SQL
DROP TABLE <TABLE名>;
```
やり直しはできないので注意！

### テーブル定義の変更

列を追加
```SQL
ALTER TABLE <TABLE名> ADD COLUMN <列の定義>;
```
列を削除
```SQL
ALTER TABLE <TABLE名> DROP COLUMN <列名>;
```
## 検索の基本

### SELECT文の基本

テーブルからデータを取り出すときにSELECT文を使う、これを問い合わせやクエリと呼ぶ。
```SQL
SELECT <列名>,......
  FROM <TABLE名>;
```
SELECT文はSELECT句、FROM句などの句からなる。句はSQL文を構成する要素でキーワードである。
e.g.)
```SQL
SELECT shohin_id,shohin_mei,shiire_tanka
  FROM Shohin;

出力

shohin_id | shohin_mei | shiire_tanka
0001      | Tシャツ　　| 500
              .
              .
              .
              .  
```
SELECT句の指定と同じ順番でデータが並ぶ。
また、データを全部出すには* を使う(並び順の指定は不可になる。)
```SQL
SELECT *
  FROM Sshohin;
```

### 列に別名を付ける

ASキーワードで列に別名をつけられる。

```SQL
SELECT shohin_id AS id,
       shohin_mei AS namae,
       shiire_tanka AS tanka
  FROM Shohin;

出力
id   | namae  | tanka
0001 | Tシャツ| 500
.....................
```
別名は日本語でもOKだが、その場合はダブルクォーテーションで囲う。

### 定数の出力
```SQL
SELECT '商品' AS mojiretsu, 38 AS kazu, '2009-09-24' AS hizuke,
       shohin_id,shohin_mei
  FROM Shohin;

出力
mojiretsu  | kazu | hizuke      |shohin_id   | shohin_mei|
商品       | 38   | 2009-09-24  | 0001       | Tシャツ
..........................................................
```

### 結果から重複行を省く
```SQL
SELECT DISTINCT shohin_bunrui
  FROM Shohin;

出力
shohin_bunrui 
キッチン用品
衣服
事務用品
```
DISTINCTキーワードを使うと重複する項目は１つにまとめられる。また、NULLも１つの項目としてまとめられる。
また、

```SQL
SELECT DISTINCT shohin_bunrui,torokubi
```
のように指定すると、２つの要素がどちらとも重複している行のみが出力される。

DISTINCTキーワードは列の先頭にしか置けないから注意！

### WHERE句による行の選択

WHERE句に条件式を書けば、その条件を満たす行のみが出力される。
e.g.)
```SQL
SELECT shohin_mei,shohin_bunrui
  FROM Shohin
WHERE shohin_bunrui = '衣服'
```
WHERE句はFROM句の直後に置く！！！

### コメント

一行
```SQL
-- 一行コメント
```
複数行
```SQL
/\*
こんな感じで
書く
\*/
```

### 算術演算子
```SQL
SELECT shohin_mei,hanbai_tanka,
       hanbai_tanka * 2,hanbai_tanka_x2
  From Shohin;

shohin_mei| hanbai_tanka | hanbai_tanka_x2
Tシャツ   | 1000         | 2000
........
```
+,-,*,/ などの算術演算子はSELECT文で使える。
NULLを含んだ計算結果は問答無用でNULLになるので注意！

### 比較演算子
```SQL
SELECT shohin_mei,shohin_bunrui
  FROM Shohin
WHERE hanbai_tanka - shiire_tanka >= 500;
```
のような感じで比較演算子を使って条件の指定ができる。

- = 等しい
- <> 等しくない

以上、以下は普通の言語と同じ。

また、日付の場合は「より小さい」が「より前」になるので注意。
また、文字列型の比較は「辞書式順序」で比較されるのでこれも注意、文字列型の数字とINTEGER型の数字ははっきりと区別される。
NULLは比較演算子で使えない、<>演算子でも不可。NULLかどうかの判定には専用のIS NULL,IS NOT NULL演算子が用意されている。

### 論理演算子

複数の条件を組み合わせることを可能にする演算子。

否定の条件を表すNOT演算子、別に使わなくてもなんとかなることが多いので無理に使わないでいい
```SQL
WHERE NOT ~
```
AND,OR演算子、条件を組み合わせられる。
```SQL
WHERE ~
  AND ~
  OR ~
```
AND,ORを併用する場合はORのほうが優先されるので注意！()でくくればANDとORをうまく併用できる。
AND,ORは真理値に基づいて条件を絞るが、比較演算子にNULLは使えないのと同じように、NULLでは真でも偽でもないUNKNOWNという第三の型になるので注意。

## 集約と並び替え

### 集約関数

データの操作、計算には関数を使う。よく使うものは

- COUNT テーブルのレコード数を数える
- SUM テーブルの数値列の合計
- AVG 同じく平均
- MAX テーブルの任意の列の最大値
- MIN 同じく最小値

e.g.)
```SQL
SELECT COUNT(\*)
  FROM Shohin;

count
-----
  8
```

NULLを除外するには具体的な列を指定する。
```SQL
SELECT COUNT(shiire_tanka)
  FROM Shohin;

count
-----
  6
(2行のNULLを含んでいたため)
```

MAX/MIN はどんなデータ型にも使えるが、SUM、AVGは無理

これらの関数はDISTINCTキーワードと組み合わせて重複を取り除いてから操作することもできる。

```SQL
SELECT COUNT (DISTINCT shohin_bunrui)
  FROM Shohin;

count
----
  3
```

### テーブルをグループに切り分ける

GROUP BY句を使うとデータをグループに分けて集約できる。
``` SQL
SELECT shohin_bunrui,COUNT(\*)
  FROM Shohin
GROUP BY shohin_bunrui;

shohin_bunrui  | count
衣服　　　　　 |  2
事務用品       |  2
キッチン用品   |  4
```

GROUP BYに指定する列を集約キーやグループ化列と呼ぶ。
書く順番はSELECT→FROM→WHERE→GROUP BYの順、ただしWHEREとGROUP BYの併用はWHEREが先に処理される。
ちなみに集約キーがNULLの場合もちゃんと項目の１つとして処理される。

### GROUP BYの鉄則

- SELECTに余計なもんを書いちゃいけない
- SELECTに書けるのは以下だけ
  - 定数
  - 集約関数
  - 集約キー
- SELECTで付けた別名は使えない。GROUP BYのほうが処理の順番が先だから処理できない
- 結果の順序はランダム、自動でソートされない

- HERE句に集約関数を書かない。COUNTの結果によって条件を分岐させたりしたいときにWHERE句にCOUNT(*) = 2とか書きたいけどこれはダメ。
- 集約関数はSELECT、HAVING句以外では使えない

### HAVING句

集約した結果を条件に指定したい場合はHAVING句を使う。
```SQL
SELECT shohin_bunrui,COUNT(\*)
  FROM Shohin
GROUP BY shohin_bunrui
  HAVING COUNT(\*) =2
```
HAVING句でも
- 定数
- 集約関数
- 集約キー
以外は書けないという制限がある。

### WHERE句との使い分け

HAVING句でもWHERE句でも集約キーに関する条件は同じように書ける。結果は同じだが、WHERE句に書くほうがいいらしい。

- HAVINGはグループに対する条件指定で、行の条件指定はWHEREに書くべき
- WHERE句のほうが処理速度が速い
ってのが理由。

### 検索結果の並べ替え

ORDER BYを使えば表示順の指定ができる、ちなみにこれを指定しないと順番は全てランダムになるので注意！
```SQL
SELECT ~
  FROM Shohin
ORDER BY hanbai_tanka;
```

必ずSELECT文の最後に置く。デフォルトで昇順、降順にするには`ORDER BY hanbai_tanka DESC`のように書く。
複数のソートキー指定も可能、左に書いたのが優先される。
NULLは先頭か末尾にまとめられる、DBMSによっては指定できる。
また、ORDER BYではSELECTで付けた別名も使用可能。

## データの更新

### INSERT文

その名の通りテーブルにレコードを挿入(つまりデータを登録)するための文。
e.g.)
```SQL
INSERT INTO ShohinIns(shohin_id,shohin_mei,shohin_bunrui,hanbai_tanka,shiire_tanka,torokubi) VALUES ('0001','Tシャツ','衣服',1000,500,'2009-09-20');
```

列名、値を()でくくった形式をリストという、INSERT文では最初に列リスト、次に値リストを指定する。
複数行の挿入を一気にやる方法もあるが、原則として一回の操作で１行を挿入する。
また、列リストはテーブルの全列に対してINSERTを行う場合は省略することができる。

### DEFAULTの扱い

テーブルの作成時にカラムにデフォルト値を指定することができる。
挿入時にこの値を使用するには、デフォルト値が指定されているカラムに該当する部分の値リストをDEFAULTと指定すればいい。
また、デフォルト値が設定されているカラムを列リスト、値リストの双方で記述しないことでもデフォルト値を暗黙的に挿入できる。
ちなみに、デフォルト値が設定されていないカラムを前述のように無視するとNULLが入る。

### 他テーブルからデータをコピー
```SQL
INSERT INTO ShohinCopy (shohin_id,shohin_mei,shohin_bunrui,hanbai_tanka,shiire_tanka,torokubi)
SELECT shohin_id,shohin_mei,shohin_bunrui,hanbai_tanka,shiire_tanka,torokubi
  FROM Shohin;
```

このようにすると、他のテーブルからデータを丸々コピーすることができる。
データのバックアップとかに使える。
ちなみに、このSELECT文ではWHERE句やGROUP BYも使用可能、ただしORDER BYは使っても意味がない

### DELETE文
```SQL
DELETE FROM <TABLE名>
```

でテーブルの全行の削除、DROP TABLEとは違ってテーブル自体は消えない.

### 探索型DELETE

一部の行だけを消す場合は探索型DELETEと呼ばれる書き方をする。
```SQL
DELETE FROM Shohin
  WHERE hanbai_tanka >= 4000;
```
ちなみに、標準ではないが多くのSQLで使用可能なTRUNCATE文がある。
DELETEとは違ってWHERE句と併用して一部の行だけ削除はできず、必ず全行削除する。
DELETE文は処理が遅い文のため、全行削除したい場合はこっちのほうが高速。

### UPDATE文

登録済みのデータを変更するための文。
```SQL
UPDATE Shohin
  SET torokubi = '2009-09-24';
```
みたいな感じ,この場合は全ての行のtorokubiカラムのデータを指定した値に変更する。

### 探索型UPDATE

一部の行のみ変更する場合は探索型DELETE文と同じようにWHERE句と組み合わせる。
```SQL
UPDATE Shohin
  SET hanbai_tanka = hanbai_tanka * 10
WHERE shohin_bunrui = 'キッチン用品';
```
もちろん列をNULLで更新することもできる、これをNULLクリアと呼ぶ。
あと、SETにカンマで区切って複数のカラムを更新することもできる。

## トランザクション

トランザクション:データベースに対する１つ以上の更新をまとめて呼ぶ時の名称
例えば、Aの販売単価を上げて、代わりにBの販売単価を下げろ、という場合に、この２つの処理は１つのトランザクションで行われるべき、という感じ。
開始時に
`BEGIN TRANSACTION`
と書けばトランザクションが開始(mysqlの場合はBEGINではなくSTART)
トランザクションの処理を確定するには`COMMIT`
取り消すには`ROLLBACK`を実行する。

## ACID特性

DBMSのトランザクションで守られなければならない4つの特性のこと。

### 原始性
トランザクションが終わった時、そこに含まれる更新処理は全て実行されるか、全て実行されないかの２択である、という性質。
つまりCOMMITかROLLBACK。これはトランザクションが中途半端な終わり方をさせないための性質。

### 一貫性
トランザクションの処理はDBにあらかじめ決められた制約を満たす、つまりNOT NULLが設定された列にNULLが入らないみたいな性質。
これを破る違法なSQL文を実行すると即座にロールバックされ、コミットしてもトランザクション内でその文だけ実行されないことになる。(postgresqlの場合は違法なSQL文が１つでもあるとトランザクション内の全ての処理が無効になる。)

### 独立性
トランザクションは入れ子構造になったりせず、独立してお互いに影響を受けない。

### 永続性
トランザクションが終了したら、コミットにせよロールバックにせよそのデータの状態が保存されるという性質。
この永続性を保証する一般的な方法はログである。

## ビュー

テーブルと同じものだが、１つだけ「実際のデータを保存しているか否か」という点で違いがある。
通常のテーブルではデータを記憶装置に保存しているが、ビューの場合はデータをどこにも保存していない。ビューは「SELECT文そのもの」を保存し、内部的にその文を実行、一時的に仮想のテーブルを作っている。

### メリット

- 実際にデータを保存していないので記憶領域の節約になる。
- 頻繁に使うSELECT文をビューに保存しておけば使いまわせる。また、ビューは元のデータを参照しているため、元データが変更されても自動で返す内容も最新のものになる。

### ビューの作り方
```SQL
CREATE VIEW ビュー名 (<ビューの列名1>,<ビューの列名2>,...)
AS
<SELECT文>
```
SELECT文の列とビューの列は並び順で一致する。
e.g.)
```SQL
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
GROUP BY shohin_bunrui;
```
実行するとビューが作成される、これはテーブルと同じように使える。
e.g.)
```SQL
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum;
```
上の文はビューのSELECT文を実行した後に、さらにSELECT文が実行されるという構成になっている。
ちなみに、ビューを元にさらにビューを定義することも可能だが、パフォーマンスが下がるのでやめたほうがいい。

### ビューの制限事項

- ビュー定義でORDER BYは使えない
  - 行には順序がないというルールからテーブルと同様にビューでもORDER BYは使えない。
- ビューに対する更新
  - テーブルと同様にビューでも更新系SQL文が実行できるが厳しい制限がつく。
    - SELECT句にDISTINCTが含まれていない。
    - FROM句に含まれるテーブルが１つだけである。
    - GROUP BY句を使用していない。
    - HAVING句を使用していない。

### ビューの削除
```SQL
DROP VIEW <ビュー名>
```

## サブクエリ

サブクエリ→**使い捨てのビュー**
ビューがSELECT文だけを保存してユーザの利便性を高める一方、サブクエリはビュー定義のSELECT文をそのままFROM句に持ち込んだもの。
```SQL
商品分類ごとに総数を表示するビュー
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
GROUP BY shohin_bunrui;

ビューの確認
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum;
```
同じ事をサブクエリでやってみる。
```SQL
SELECT shohin_bunrui, cnt_shohin
  FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
          FROM Shohin
        GROUP BY shohin_bunrui) AS ShohinSum;
```
ShohinSumというのがこのサブクエリの名前だが、これはビューと違って保存はされない。名前の通りサブ(下位)のクエリ(問い合わせ)である。処理の流れ的には内側のSELECT文(サブクエリ)が実行されたのちに外側のクエリが実行される。
また、サブクエリはネストすることもできるが、読みにくいから出来るだけやらないほうがいい。

### スカラ・サブクエリ

**必ず１行1列だけの戻り値を返す**サブクエリのこと。

#### 活用例：WHERE句で使う

「販売単価が全体の平均単価より高い商品だけを検索する」時にはどういう風に書くか。
```SQL
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin
WHERE hanbai_tanka > AVG(hanbai_tanka);
```
それっぽいけど集約関数はWHERE句には使えない制限がある。
そこでサブクエリの出番。まず、販売単価の平均を求めるクエリは
```SQL
SELECT AVG(hanbai_tanka)
  FROM Shohin;
```
これを実行すると、
```SQL
          avg          
-----------------------
 2097.5000000000000000
(1 row)
```
こんな感じになる。これはスカラ値(１行1列)であることは明白。
このサブクエリを利用すれば、
```SQL
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
                        FROM Shohin);
```
最初の文はこのように書ける。サブクエリの部分は実行結果の2097.5に置き換わるため、有効な文となる。
ちなみに、サブクエリはWHERE句に限らずほとんどどの句でも使える。
ただ、**サブクエリが絶対に複数行を返さないようにする**ことだけは気をつけよう。

## 相関サブクエリ

相関サブクエリは「商品分類ごとの平均販売単価を比較する」ような状況で使われる。先ほどの通常のサブクエリでは全体の平均単価を条件として比較することができたが、相関サブクエリでは条件を絞った状況下での条件比較を行うことができる。
まずは商品分類ごとの平均価格を求める方法である。
```SQL
SELECT AVG(hanbai_tanka)
  FROM Shohin
GROUP BY shohin_bunrui;
```
これをそのままWHEREに渡しても複数行の結果となるため実行できない。
e.g.)
```SQL
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
                        FROM Shohin
                      GROUP BY shohin_bunrui);
```
ここで相関サブクエリが使える。１行追加するだけで求めたい結果が得られる。
```SQL
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin AS S1
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
                        FROM Shohin AS S2
                      WHERE S1.shohin_bunrui = S2.shohin_bunrui
                      GROUP BY shohin_bunrui);
```

## 関数、述語、CASE式


### 算術関数

ROUND関数などはNUMERIC型という特殊なデータ型でしか使えない。NUMERICで(全体の桁数、小数の桁数)で指定する。
サンプル用データの作成
```SQL
CREATE TABLE SampleMath
(m NUMERIC (10,3),
 n INTEGER,
 p INTEGER);

 BEGIN TRANSACTION;

 INSERT INTO SampleMath(m, n, p) VALUES(500, 0, NULL);
 INSERT INTO SampleMath(m, n, p) VALUES(-180, 0, NULL);
 INSERT INTO SampleMath(m, n, p) VALUES(NULL, NULL, NULL);
 INSERT INTO SampleMath(m, n, p) VALUES(NULL, 7, 3);
 INSERT INTO SampleMath(m, n, p) VALUES(NULL, 5, 2);
 INSERT INTO SampleMath(m, n, p) VALUES(NULL, 4, NULL);
 INSERT INTO SampleMath(m, n, p) VALUES(8, NULL, 3);
 INSERT INTO SampleMath(m, n, p) VALUES(2.27, 1, NULL);
 INSERT INTO SampleMath(m, n, p) VALUES(5.555, 2, NULL);
 INSERT INTO SampleMath(m, n, p) VALUES(NULL, 1, NULL);
 INSERT INTO SampleMath(m, n, p) VALUES(8.76, NULL, NULL);

 COMMIT;
```

#### ABS -絶対値
```SQL
 SELECT m, ABS(m) AS abs_col
  FROM SampleMath;
=>
    m     | abs_col 
----------+---------
  500.000 | 500.000
 -180.000 | 180.000
          |        
          |        
          |        
          |        
    8.000 |   8.000
    2.270 |   2.270
    5.555 |   5.555
          |        
    8.760 |   8.760
```
NULLの部分には何も入っていないが、ほとんどの関数はNULLに対してはNULLを返すようになっている。

#### MOD -剰余
```SQL
SELECT n,p, MOD(n,p) AS mod_col
  FROM SampleMath;

=>
n | p | mod_col 
---+---+---------
 0 |   |        
 0 |   |        
   |   |        
 7 | 3 |       1
 5 | 2 |       1
 4 |   |        
   | 3 |        
 1 |   |        
 2 |   |        
 1 |   |        
   |   |        
```
SQL SERVERにはないので注意

#### ROUND -四捨五入

`ROUND(対象数、丸めの桁数)`で指定する。
```SQL
SELECT m, n, ROUND(m,n) AS round_col
FROM SampleMath;
=>
    m     | n | round_col 
----------+---+-----------
  500.000 | 0 |       500
 -180.000 | 0 |      -180
          |   |          
          | 7 |          
          | 5 |          
          | 4 |          
    8.000 |   |          
    2.270 | 1 |       2.3
    5.555 | 2 |      5.56
          | 1 |          
    8.760 |   |          
```
### 文字列関数
```SQL
CREATE TABLE SampleStr
(str1 VARCHAR(40),
 str2 VARCHAR(40),
 str3 VARCHAR(40)
);

BEGIN TRANSACTION;

INSERT INTO SampleStr (str1,str2,str3) VALUES('あいう', 'えお', NULL);
INSERT INTO SampleStr (str1,str2,str3) VALUES('abc', 'def', NULL);
INSERT INTO SampleStr (str1,str2,str3) VALUES('山田', '太郎', 'です');
INSERT INTO SampleStr (str1,str2,str3) VALUES('aaa', NULL ,NULL);
INSERT INTO SampleStr (str1,str2,str3) VALUES(NULL, 'あああ', NULL);
INSERT INTO SampleStr (str1,str2,str3) VALUES('@!#$%', NULL, NULL);
INSERT INTO SampleStr (str1,str2,str3) VALUES('ABC', NULL, NULL);
INSERT INTO SampleStr (str1,str2,str3) VALUES('aBC', NULL, NULL);
INSERT INTO SampleStr (str1,str2,str3) VALUES('abc太郎', 'abc', 'ABC');
INSERT INTO SampleStr (str1,str2,str3) VALUES('abcdefabc', 'abc', 'ABC');
INSERT INTO SampleStr (str1,str2,str3) VALUES('ミックマック', 'ッ', 'っ');

COMMIT;

=>
     str1     |  str2  | str3 
--------------+--------+------
 あいう       | えお   | 
 abc          | def    | 
 山田         | 太郎   | です
 aaa          |        | 
              | あああ | 
 @!#$%        |        | 
 ABC          |        | 
 aBC          |        | 
 abc太郎      | abc    | ABC
 abcdefabc    | abc    | ABC
 ミックマック | ッ     | っ
```
#### || -連結
```SQL
SELECT str1, str2, str1 || str2 AS str_concat
  FROM SampleStr;

=>
     str1     |  str2  |   str_concat   
--------------+--------+----------------
 あいう       | えお   | あいうえお
 abc          | def    | abcdef
 山田         | 太郎   | 山田太郎
 aaa          |        | 
              | あああ | 
 @!#$%        |        | 
 ABC          |        | 
 aBC          |        | 
 abc太郎      | abc    | abc太郎abc
 abcdefabc    | abc    | abcdefabcabc
 ミックマック | ッ     | ミックマックッ
```
3つ以上の文字列の連結も可能。

#### LENGTH -文字列長

まあ分かると思うので省略

#### LOWER -小文字化

アルファベット以外には関係ない

#### UPPER -大文字化

#### REPLACE文字列の置換

`REPLACE(対象文字列、置換前の文字列、置換後の文字列)`
```SQL
SELECT str1, str2, str3, REPLACE(str1, str2, str3) AS rep_str
  FROM SampleStr;
=>
     str1     |  str2  | str3 |   rep_str    
--------------+--------+------+--------------
 あいう       | えお   |      | 
 abc          | def    |      | 
 山田         | 太郎   | です | 山田
 aaa          |        |      | 
              | あああ |      | 
 @!#$%        |        |      | 
 ABC          |        |      | 
 aBC          |        |      | 
 abc太郎      | abc    | ABC  | ABC太郎
 abcdefabc    | abc    | ABC  | ABCdefABC
 ミックマック | ッ     | っ   | ミっクマっク
```
#### SUBSTRING -文字列の切り出し

`SUBSTRING(対象文字列 FROM 切り出し開始位置 FOR 切り出す文字数)`

```SQL
SELECT str1, SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
  FROM SampleStr;
=>
     str1     | sub_str 
--------------+---------
 あいう       | う
 abc          | c
 山田         | 
 aaa          | a
              | 
 @!#$%        | #$
 ABC          | C
 aBC          | C
 abc太郎      | c太
 abcdefabc    | cd
 ミックマック | クマ
```
標準SQLで認められている機能だが、POSTGRESQLとMySQLのみでしか使えない。

### 日付関数

DBMSによって実装が異なるので標準SQLで定められているものだけ紹介。

#### CURRENT_DATE - 現在の時刻

SQLが実行された日付を返す。
```SQL
SELECT CURRENT_DATE;
```
```
date
-------
2020-03-12
```

#### CURRENT_TIME - 現在の時間

SQLを実行した時間を返す。
```SQL
SELECT CURRENT_TIME;
```
```
timetz
-------
17:26:50.995+09
```

#### CURRENT_TIMESTAMP - 現在の日時

CURRENT_DATEとCURRENT_TIMEを合体させたような機能。

#### EXTRACT - 日付要素の切り出し

日付データから「年」とか「日」を切り出す時に使う。
```SQL
SELECT CURRENT_TIMESTAMP,
EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year
```

```
 now                       | year |
2020-03-12 21:15:33.987+09   2020
```

### 変換関数

#### CAST - 型変換

型変換を行う関数、DBMSによって書き方が異なるので注意。例はPostgreSQL
```SQL
SELECT CAST('0001' AS INTEGER) AS int_col

int_col
---------
1
```

#### COALESCE - NULLを値へ変換

コアレスと読む、可変個の引数を受け取り左から順に引数を見て、最初にNULLでない値を返す。

### 述語

述語：戻り値が真偽値になる関数のこと、> = などの比較演算子も述語の一種。

#### LIKE述語

文字列の部分一致検索を行うための述語。
一致検索の種類

前方一致: 検索対象文字列が対象文字列の最初にある場合のみ一致
```SQL
SELECT * FROM SampleLike WHERE str LIKE 'ddd%';
```
中間一致: 検索対象文字列が対象文字列の「どこか」にあれば一致
```SQL
SELECT * FROM SampleLike WHERE str LIKE '%ddd%';
```
後方一致: 検索対象文字列が対象文字列の最後にある場合のみ一致
```SQL
SELECT * FROM SampleLike WHERE str LIKE '%ddd';
```

#### BETWEEN述語

範囲検索を行う述語。
```SQL
SELECT * FROM Shohin
WHERE hanbai_tanka BETWEEN 100 AND 1000;
```
のように書けば販売単価が100~1000の間の商品を取得できる。

#### IS NULL, IS NOT NULL

NULL判定を行うための特殊な述語、通常の比較演算子ではNULLを判定できないので注意。

#### IN述語

ORの便利な省略形。

```SQL
SELECT * FROM Shohin
WHERE shiire_tanka = 320
OR shiire_tanka = 500
OR shiire_tanka = 5000;
```
を
```SQL
SELECT * FROM Shohin
WHERE shiire_tanka IN (320, 500, 5000);
```
のように書き換えられる。
否定形のNOT_INもある。

ちなみに引数には具体的な値以外にもサブクエリも指定できる。

#### EXISTS述語

サブクエリを引数にとってある条件に合致するレコードが存在するか否かを調べる。

### CASE式

e.g.)
```SQL
CASE WHEN <評価式> THEN <式>
     WHEN <評価式> THEN <式>
     WHEN <評価式> THEN <式>
     WHEN <評価式> THEN <式>
        ・
        ・
        ・
    ELSE <式>
END
```

評価式は「列=値」のように真理値を返す式、この値がTRUEであればTHEN以降の式が返されてCASE式は終了する。
どれもFALSEであれば最後にELSEで指定した式が返される。

#### 使い方
```SQL
SELECT shohin_mei,
       CASE WHEN shohin_mei = '衣服'
       THEN 'A:' || shohin_bunrui
       CASE WHEN shohin_mei = '事務用品'
       THEN 'B:' || shohin_bunrui
       CASE WHEN shohin_mei = 'キッチン用品'
       THEN 'C:' || shohin_bunrui
       ELSE NULL
    END AS abc_shohin_bunrui
FROM Shohin;
```
```
実行結果
shohin_mei  | abc_shohin_bunrui
Tシャツ      | A:衣服
ホチキス     | B:事務用品
包丁         | C:キッチン用品
```
※注意点
- ELSE NULL は省略しても同じことだが明示的に書いておいた方が良い
- 最後のENDを忘れやすいので忘れないように！

## 集合演算

テーブルやビュー、クエリの実行結果などのレコードの集合の足し算と引き算を行うこと。

#### テーブルの足し算　UNION

集合論の和集合と同じ操作を行う。
テーブルAが

```SQL
shohin_id | shohin_mei
0001      | ラーメン
0002      | チャーハン
0003      | 餃子
```
テーブルBが
```SQL
shohin_id | shohin_mei
0001      | ラーメン
0003      | 餃子
0004      | 麻婆豆腐
```
これらをUNIONで結合すると
```SQL
SELECT shohin_id, shohin_mei
  FROM TableA
UNION
SELECT shohin_id, shohin_mei
  FROM TableB;

実行結果
shohin_id | shohin_mei
0001      | ラーメン
0002      | チャーハン
0003      | 餃子
0004      | 麻婆豆腐
```
このように重複行は排除されて表示される。

※注意
- 演算対象のレコード数が一致していること
- 演算対象のレコードのデータ型が一致していること
- SELECT文では何を指定してもいいが、GROUP BYは最後に一つだけしか書けない

**ALLオプション**

以下のようにALLキーワードを付け加えると重複行を排除しなくなる。
```SQL
SELECT shohin_id, shohin_mei
  FROM TableA
UNION ALL
SELECT shohin_id, shohin_mei
  FROM TableB;

実行結果
shohin_id | shohin_mei
0001      | ラーメン
0002      | チャーハン
0003      | 餃子
0001      | ラーメン
0003      | 餃子
0004      | 麻婆豆腐
```

#### 共通部分の抽出　INTERSECT

集合論の積集合と同じ。
```SQL
SELECT shohin_id, shohin_mei
  FROM TableA
INTERSECT
SELECT shohin_id, shohin_mei
  FROM TableB;

実行結果
shohin_id | shohin_mei
0001      | ラーメン
0003      | 餃子
```
これにもALLオプションがあり、重複行を排除しないようにすることもできる。

#### レコードの引き算 EXCEPT

集合の引き算を行う。
```SQL
SELECT shohin_id, shohin_mei
  FROM TableA
UNION ALL
SELECT shohin_id, shohin_mei
  FROM TableB;

実行結果
shohin_id | shohin_mei
0002      | チャーハン
```
ちなみに(2-4)と(4-2)の結果が違うように順番を入れ替えると結果も変わる。

## 結合

テーブルを行方向ではなく列方向に連結する演算。

### 内部結合 - INNER JOIN

e.g.)
```SQL
SELCT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
  FROM TenpoShohin AS TS INNER JOIN Shohin AS S
    ON TS.shohin_id = S.shohin_id;
```
FROM句に結合する複数のテーブルを記述、そしてONで結合に使用するキーを指定するのがポイント。
テーブルを結合してしまえば、普通のテーブルのようにWHEREで条件を指定したり、ORDER BYで並べ替えたりすることが可能。

### 外部結合 - OUTER JOIN

e.g.)
```SQL
SELCT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
  FROM TenpoShohin AS TS RIGHT OUTER JOIN Shohin AS S
    ON TS.shohin_id = S.shohin_id;
```
外部結合では片方にしか存在しないデータでも必ず出力する。
RIGHT OUTER　か　LEFT OUTERを指定する。これはどちらのテーブルをマスタにするかを指定していて、
指定した方のデータは対応するもう片方のテーブルの値がなくても出力する。

ちなみに、結合では3つ以上のテーブルも結合できる。その場合は2つのテーブルを結合した結果をもう一つのテーブルと結合して...のような流れになる。

### クロス結合 - CROSS JOIN

実務ではまず使われることがない結合方法、2つのテーブルについて全ての組み合わせを出力する。

e.g.)
```SQL
SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei
  FROM TenpoShohin AS TS CROSS JOIN Shohin AS S;
```
実務で使われない理由
- 結果に使い道がない
- 演算に多くの時間とマシンパワーを使用してしまう

内部結合はクロス結合の組み合わせの一部であるという意味で「内部」、外部結合はクロス結合に存在しない組み合わせを持つという意味で「外部」である。

## 高度な処理

### GROUPING演算子

GROUP BYとSUMを使えば特定の集約キーにおける小計は出すことができるが、さらにその合計を表示することはできない。合計と小計を同時に表示するためにはGROUPING演算子を使う必要がある。
- ROLLUP
- CUBE
- GROUPING SETS
の3種類がある。

### ROLLUP
```SQL
SELECT shohin_bunrui, SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
GROUP BY ROLLUP(shohin_bunrui);

実行結果
shohin_bunrui    |  sum_tanka
                    16780
キッチン用品          11180
事務用品              600
衣服                 5000
```
この演算子では
1. GROUP BY()
2. GROUP BY(shohin_bunrui)
が裏で実行されていて、1の何も指定していないGROUP BYが合計行のレコード(超集合行)となっている。

#### 集約キーを複数指定する場合

集約キーに"登録日"カラムを追加するとこんな感じになる。
```SQL
shohin_bunrui   |  torokubi   |  sum_tanka
                                  20780 # 合計
キッチン用品                        8980 # 小計
キッチン用品       2008-04-09       880
キッチン用品       2009-04-09       6600
キッチン用品       2009-09-20       1500
事務用品                            5500 # 小計
事務用品           2010-11-15       2200
事務用品           2011-09-08       3300
衣服                               6300 # 小計
衣服              2012-03-15       2300
衣服                               4000
```
商品分類と登録日をキーとして集約した結果の小計、合計が表示されている。

### GROUPING演算子

上の例では衣服のtorokubiがNULLの場合はNULLが集約キーとなっていて、小計を表す超集合行と見分けがつきにくい。
そのため、超集合行のNULLを判別するためにGROUPING演算子が用意されている。
```SQL
SELECT GROUPING(shohin_bunrui), AS shohin_bunrui,
       GROUPING(torokubi) AS torokubi, SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY( ROLLUP(shohin_bunrui, torokubi));
```

```
shohin_bunrui      torokubi     sum_tanka
------------------------------------------
1                     1         16780
0                     1         11180
0                     0         880
0                     0         6800
0                     0         3500
0                     1         600
0                     0         500
0                     0         100
0                     1         5000  # 超集合行のNULLは1
0                     0         1000
0                     0         4000  # オリジナルデータのNULLは0
```
これで超集合行のNULLとオリジナルデータのNULLを判別することができる。
これを使えばCASE文などと合わせて表示をより分かりやすくできる。
e.g.)
```SQL
SELECT CASE WHEN GROUPING(shohin_bunrui) = 1,
            THEN '商品分類　合計'
            ELSE shohin_bunrui END AS shohin_bunrui,
      CASE WHEN GROUPING(torokubi) = 1,
            THEN '登録日　合計'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
      SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY ROLLUP(shohin_bunrui, torokubi);
```
### CUBE - データで積み木を作る
```SQL
SELECT CASE WHEN GROUPING(shohin_bunrui) = 1,
            THEN '商品分類　合計'
            ELSE shohin_bunrui END AS shohin_bunrui,
      CASE WHEN GROUPING(torokubi) = 1,
            THEN '登録日　合計'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
      SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY CUBE(shohin_bunrui, torokubi);
```
```SQL
shohin_bunrui      torokubi       sum_tanka
商品分類　合計       登録日合計       16780
商品分類　合計      2008-04-28       880
商品分類　合計      2009-01-05       6800
商品分類　合計      2009-09-11       500
商品分類　合計      2009-09-20       4500
商品分類　合計      2009-11-11       100
商品分類　合計                       4000

# 以下ROLLUPと同じ
```
CUBEでは
1. GROUP BY()
2. GROUP BY(shohin_bunrui)
3. GROUP BY(torokubi)
4. GROUP BY(shohin_bunrui, torokubi)

と、先ほどの例と比べてtorokubiだけで集約化したデータも含まれている。
このようにCUBEはGROUP BYに与えられた集約キーの「全ての可能な組み合わせ」を一つの結果にする機能である。

### GROUPING SETS - 欲しい積み木だけ取得

GROUPING SETSを使うと、ROLLUPやCUBEから欲しい結果だけを取得できる。例えばshohin_bunruiとtorokubiのそれぞれを
単独で集約キーとして指定した結果のみを取得したい場合は
```SQL
SELECT CASE WHEN GROUPING(torokubi) = 1,
            THEN '登録日　合計'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
      SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY GROUPING SETS(shohin_bunrui, torokubi);
```
のように書けば良い。

## 参考
https://af.moshimo.com/af/c/click?a_id=4491981&p_id=170&pc_id=185&pl_id=4062&url=https%3A%2F%2Fwww.amazon.co.jp%2Fgp%2Fsearch%3Fie%3DUTF8%26keywords%3D%25E3%2582%25BC%25E3%2583%25AD%25E3%2581%258B%25E3%2582%2589%25E3%2581%25AF%25E3%2581%2598%25E3%2582%2581%25E3%2582%258B%25E3%2583%2587%25E3%2583%25BC%25E3%2582%25BF%25E3%2583%2599%25E3%2583%25BC%25E3%2582%25B9
