# Application Template for Rails 4.0.2

This Rails 4.0 Application Template is just for private use, and is conscious of the future Rails 4.1.

## Organization

* configure .gitignore
* configure Gemset
** Ruby 2.1
** Rails 4.0.2
* Install Gem into vendor/bundle
* configure application.rb
* configure secret_token.rb
* configure Japanese locale
* configure application.js
* configure HAML
* configure Bootstrap3/Font-Awaresome
* configure SimpleForm
* configure kaminari
* configure mysql
* configure RSpec
* configure spring/guard
* configure git flow



以下のライブラリを事前にインストールしておくこと
* libxml2 libxslt libiconv

ただしMacとHomebrew 0.9だとlibiconvがうまく入らないことがあるので、以下のような感じでインストール

* brew install libxml2 libxslt
* brew link libxml2 libxslt

* wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.13.1.tar.gz
* tar xvfz libiconv-1.13.1.tar.gz
* cd libiconv-1.13.1
* ./configure --prefix=/usr/local/Cellar/libiconv/1.13.1
* make
* sudo make install

## Usage

### 作成方法

1. プロジェクト用のディレクトリにRakefileを置く
2. rake new appname=アプリ名

これでデータベース作成も含めてすべて自動で実行される
(newのかわりにadd、createでもよい)

### 削除方法

1. rake kill appname=アプリ名

(killのかわりに clear、remove、delete、destroyでもよい)
これでデータベースも含めてすべて削除される
