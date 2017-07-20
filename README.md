
<!-- README.md is generated from README.Rmd. Please edit that file -->
R binding for JUMAN++
=====================

This package is made for mainly Japanese.

表記ゆれや話し言葉に強いと言われる日本語形態素解析器 **JUMAN++** を R から操作するためのパッケージです。

**注: このパッケージは開発中です。**

インストール
============

JUMAN++のインストール
---------------------

現在、JUMAN++は Windows には対応していないようです。

### Mac

Homebrew でインストールできます。

``` sh
$ brew install jumanpp
```

### Linux(例: Ubuntu)

``` sh
$ wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.01.tar.xz
$ tar xJvf jumanpp-1.01.tar.xz
$ cd jumanpp-1.01/
$ ./configure
$ make
$ sudo make install
```

`rjumanpp`のインストール
------------------------

``` r
devtools::install_github("ymattu/rjumanpp")
```

使い方
======

``` r
library(rjumanpp)
```

単純な形態素解析
----------------

文字列を引数として単純な形態素解析をしたい場合は、`rjumanpp_c()`関数を使います。 `RMeCab::RMeCabC()` のように、品詞がnames属性のリストを返します。

``` r
jum_c("私には外国人参政権がある。")
#> [[1]]
#> 名詞 
#> "私" 
#> 
#> [[2]]
#> 助詞 
#> "に" 
#> 
#> [[3]]
#> 助詞 
#> "は" 
#> 
#> [[4]]
#>   名詞 
#> "外国" 
#> 
#> [[5]]
#> 名詞 
#> "人" 
#> 
#> [[6]]
#>   名詞 
#> "参政" 
#> 
#> [[7]]
#> 名詞 
#> "権" 
#> 
#> [[8]]
#> 助詞 
#> "が" 
#> 
#> [[9]]
#>   動詞 
#> "ある" 
#> 
#> [[10]]
#> 特殊 
#> "。"
```

分かち書き
----------

単純に文章を入力して分かち書きを得たい場合は `rjumanpp_wakati()`関数を使います。

``` r
jum_wakati("私には外国人参政権がある。")
#> [1] "私 に は 外国 人 参政 権 が ある 。"
```

品詞を指定して分かち書きを得ることもできます。

``` r
jum_wakati("私には外国人参政権がある。", pattern = "名詞")
#> [1] "私 外国 人 参政 権"
```

`pattern`引数は ICU 正規表現による指定が可能で、`pattern = "名詞|形容詞"`のように書くこともできます。

Future Work
===========

-   \[ \] 表記ゆれ、代表表記への対応
-   \[ \] ファイル入力への対応
-   \[ \] データフレームへの対応
