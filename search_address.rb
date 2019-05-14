require 'csv' # csvライブラリを読み込み
require 'kconv' #日本語文字コードの変換を手軽に行うためのライブラリ

# グローバル変数に指定されたファイルを全て読み込んで、その各行を要素としてもつ配列を用意。
CSV_FILE = File.readlines('KEN_ALL.CSV', encoding: 'SJIS')
            .map { |csv| csv.encode('utf-8') }
            .freeze

# n-gramについての記事を参考に ->  2文字：バイグラムで指定する
# https://www.xmisao.com/2016/10/29/create-ngram-using-each-cons-in-ruby.html
class String
  def to_ngram(n)
    self.each_char.each_cons(n).map(&:join)
  end
end

# 入力値とcsvのレコードを受け取り、マッチングを行う
def match_pattern(address_data, search_word)
  # csvのレコード内に入力値が含まれているかを判定する
  search_word.each { |str| return false unless address_data.include?(str) }
  true
end

# 入力値を受け取り、match_patternがtrueの場合にCSV_FILEのレコードを表示する
def search_record(search_word)
  # 対象とするファイルの全ての行を1行ずつ読み込む ->  File.opneからfileをeachで廻す
  # https://www.buildinsider.net/language/rubytips/0021
  File.open('sample.csv', 'r') do |file|
    file.each_line do |line|
      strs = line.split(' ') # split ' 'で配列を分割
      strs_idx = strs[0].to_i # 配列の0番目をンデックス番号で保存
      address_data = strs[1..-1].join # 1番目〜住所など値をjoinでつなげる
      # マッチングメソッドの条件がtrueの場合に、CSV_FILEのstrs_idxがあるものを表示
      puts CSV_FILE[strs_idx] if match_pattern(address_data, search_word)
    end
  end
end

# 入力値を受け取りバイグラムで値を保存
search_word = ARGV[0].to_ngram(2)
# 検索メソッドにバイグラムで値をを渡し検索をかける
search_record(search_word)


