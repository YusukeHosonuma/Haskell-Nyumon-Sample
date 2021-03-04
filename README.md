[Haskell入門 関数型プログラミング言語の基礎と実践のサンプルコード](https://github.com/hiratara/Haskell-Nyumon-Sample)を最新の環境でビルドできるようにしたもの。

**本リポジトリは一読者が勝手に対応したもので、fork元である[公式リポジトリ](https://github.com/hiratara/Haskell-Nyumon-Sample)や著者陣、出版社とは何の関係もありません。**

## 主な変更点

- ✅ 基本的にStackageの最新のLTSを利用するように（古いGHCだとビルドに失敗する問題に遭遇したため）。
- ✅ ビルドエラーになる箇所を`[FIXED]`のコメントをつけて修正。
- ✅ `package.yaml`を利用するように。
- ✅ `hie.yaml`を作成し、VSCode上で[Haskell拡張](https://marketplace.visualstudio.com/items?itemName=haskell.haskell)が動作するように。（[implicit-hie](https://hackage.haskell.org/package/implicit-hie)で生成）

## 動作確認環境

- macOS: Big Sur 11.2.2
- Stack: Version 2.5.1.1 x86_64

## TODO

- [x] 09章
- [ ] 10章
- [x] 11章

## 09章

```bash
$ code ./chap11-samples # VSCodeのHaskell拡張を動かすためには個別に開く必要あり
$ stack build --test hjq
$ echo '[ { "age": 25, "name": "佐藤太郎", "tel-number": "111-1111" }, { "age": 26, "name": "斎藤花子", "tel-number": "222-2222" }, { "age": 27, "name": "山田太郎", "tel-number": "333-3333" } ]' | stack exec hjq -- '{"name":.[2].name,"tel-numer":.[2].tel-number}'
```

### コードの変更点
なし

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
- deriveJSON defaultOptions ''UUID
+ -- deriveJSON defaultOptions ''UUID
```
