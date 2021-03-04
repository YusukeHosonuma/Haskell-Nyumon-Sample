[Haskell入門 関数型プログラミング言語の基礎と実践のサンプルコード](https://github.com/hiratara/Haskell-Nyumon-Sample)を最新の環境でビルドできるようにしたもの。

**本リポジトリは一読者が勝手に対応したもので、fork元である[公式リポジトリ](https://github.com/hiratara/Haskell-Nyumon-Sample)や著者陣、出版社とは何の関係もありません。**

## 主な変更点

- ✅ 基本的にStackageの最新のLTSを利用するように（古いGHCだとビルドに失敗する問題に遭遇したため）。
- ✅ ビルドエラーになる箇所を`[FIXED]`のコメントをつけて修正。
- ✅ `package.yaml`を利用するように。
- ✅ `hie.yaml`を作成し、VSCode上で[Haskell拡張](https://marketplace.visualstudio.com/items?itemName=haskell.haskell)が動作するように。

## 動作確認環境

- macOS: Big Sur 11.2.2
- Stack: Version 2.5.1.1 x86_64

## TODO

- [ ] 9章
- [ ] 10章
- [x] 11章

## 11章

```bash
$ code ./chap11-samples # VSCodeのHaskell拡張を動かすためには個別に開く必要あり
$ stack build
```
