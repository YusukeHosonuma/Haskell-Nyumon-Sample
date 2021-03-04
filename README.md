[Haskell入門 関数型プログラミング言語の基礎と実践のサンプルコード](https://github.com/hiratara/Haskell-Nyumon-Sample)を最新の環境でビルドできるようにしたもの。

**本リポジトリは一読者が勝手に対応したもので、fork元である[公式リポジトリ](https://github.com/hiratara/Haskell-Nyumon-Sample)や著者陣、出版社とは何の関係もありません。**

## 主な変更点

- ✅ 基本的にStackageの最新のLTSを利用するように（古いGHCだと`ExitFailure 1`で失敗する問題に遭遇したため）。
- ✅ ビルドエラーになる箇所を`[FIXED]`のコメントをつけて修正。
- ✅ `package.yaml`を利用するように。
- ✅ `hie.yaml`を作成し、VSCode上で[Haskell拡張](https://marketplace.visualstudio.com/items?itemName=haskell.haskell)が動作するように。（[implicit-hie](https://hackage.haskell.org/package/implicit-hie)で生成）

## 動作確認環境

- macOS: Big Sur 11.2.2
- Stack: Version 2.5.1.1 x86_64

## TODO

- [x] 09章
- [x] 10章
- [x] 11章

## 09章

```bash
$ code ./chap09-samples # VSCodeのHaskell拡張を動かすためには個別に開く必要あり
$ stack build --test
$ echo '[ { "age": 25, "name": "佐藤太郎", "tel-number": "111-1111" }, { "age": 26, "name": "斎藤花子", "tel-number": "222-2222" }, { "age": 27, "name": "山田太郎", "tel-number": "333-3333" } ]' | stack exec hjq -- '{"name":.[2].name,"tel-numer":.[2].tel-number}'
```

### コードの変更点
なし

## 10章

```bash
$ code ./chap10-samples  # 現時点ではVSCodeのHaskell拡張が正しく動作せず
$ cat data/schema.sql | sqlite3 weight.db
$ stack build --test weight-recorder
$ stack exec weight-recorder -- --db '"weight.db"' --port 8080
```

### コードの変更点

StackageLTSで[Spock](https://hackage.haskell.org/package/Spock)などが含まれていなかったので、`stack.yaml`の`extra-deps`にて依存パッケージを明示。

```yaml
extra-deps:
  - HDBC-sqlite3-2.3.3.1
  - relational-query-0.8.4.0
  - relational-query-HDBC-0.6.0.3
  - persistable-record-0.4.2.0
  - names-th-0.2.0.3
  - relational-schemas-0.1.3.1
  - Spock-0.14.0.0
  - Spock-core-0.14.0.0
  - reroute-0.6.0.0
  - stm-containers-1.2
  - focus-1.0.1.4
  - stm-hamt-1.2.0.4
  - primitive-extras-0.8
  - primitive-unlifted-0.1.3.0
```

`Just user`を直接取れなかったので、一度`Maybe User`を取り出してから case-of で処理するように。

```diff
 -- Web/Action/NewRecord.hs
 -- Web/View/Main.hs

- Just user <- wrconUser <$> getContext
+ mu <- wrconUser <$> getContex
+ case mu of
+   Just user -> do
...
+   Nothing -> do
+     redirect "/" -- 暫定処理
```

## 11章

```bash
$ code ./chap11-samples # VSCodeのHaskell拡張を動かすためには個別に開く必要あり
$ stack build
```
### コードの変更点

`InputT IO`は既に`Catch.MonadThrow`および`Catch.MonadCache`のインスタンスであったため不要コードをコメントアウト。
（`catch`関数はインポートできない状態になっていたため、インポート文も削除）

```diff
 -- client.hs

- import qualified System.Console.Haskeline.MonadException as Haskeline (catch)
+ -- import qualified System.Console.Haskeline.MonadException as Haskeline (catch)

- instance Catch.MonadThrow (InputT IO) where
-     throwM e = liftIO $ throwIO e
- instance Catch.MonadCatch (InputT IO) where
-     catch act handler = Haskeline.catch act $ \e ->
-         if isSyncException e
-             then handler e
-             else throwIO e
+ -- instance Catch.MonadThrow (InputT IO) where
+ --     throwM e = liftIO $ throwIO e
+ -- instance Catch.MonadCatch (InputT IO) where
+ --     catch act handler = Haskeline.catch act $ \e ->
+ --         if isSyncException e
+ --             then handler e
+ --             else throwIO e
```

`UUID`は既に`FromJSON`と`ToJSON`のインスタンスだったのでコメントアウト。

```diff
 -- Auction/Types.hs

- deriveJSON defaultOptions ''UUID
+ -- deriveJSON defaultOptions ''UUID
```
