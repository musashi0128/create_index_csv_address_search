# 課題提出用のリポジトリ
  * 技術説明について / 実行説明について / 該当のソースコード / 生成される.csvファイル

# 技術説明書について
 * コード内にてコメントで記述をしております

# 実行説明書について
 * 機能1 => インデックスファイルの作成
   * 対象ファイル => create_index_nopass.rbとcreate_index_onpass.rb
   * 説明 => zipファイルの解凍 -> 読み込み -> csvファイルの生成 / zipファイルにパスワードがある場合にも対応(パスワードはベタ打ち)
   * 実行方法 => ```$ ruby create_index_nopass.rb```

 * 機能2 => 作成したインデックスファイルを元に住所レコードの検索
   * 対象ファイル => serch_address.rb
   * 説明 => 例1の部分はクリア(結合は行っておりません) / 例2のN-Gram(2)で"東京都"の場合、"東京, 京都"での実装はできておりません。
   * 実行方法 => ```$ ruby serch_address.rb 渋谷``` / ```$ ruby serch_address.rb 東京都```


# 参考にした記事
  * RubyでZipを使う記事 -> パスワード有/無について
    * https://qiita.com/ya-mada/items/c162383eda33dc516c39

  * rubyでのファイル操作について
    * https://www.buildinsider.net/language/rubytips/0021
    * https://docs.ruby-lang.org/ja/latest/method/IO/s/readlines.html

  * CSVファイルを１行ずつ取り出す
    * https://uxmilk.jp/19202

  * n-gramに関する記事
    * https://www.xmisao.com/2016/10/29/create-ngram-using-each-cons-in-ruby.html

  * include?に関する記事
    * https://www.sejuku.net/blog/14709
