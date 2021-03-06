require 'zip' # zipライブラリを読み込み
require 'csv' # csvライブラリを読み込み
require 'kconv' #日本語文字コードの変換を手軽に行うためのライブラリ

# zip形式ファイルを解凍
def uncompress(path, outpath)
  entrys = []
  Dir.mkdir(outpath) unless Dir.exist?(outpath)
  # 2つ目の引数は offset
  Zip::InputStream.open(path, 0) do |input|
    # get_next_entryすると input の offset（ポインタ）が動く
    while (entry = input.get_next_entry)
      # 書き出し先を作る
      save_path = File.join(outpath, entry.name)
      File.open(save_path, 'w') do |wf|
        # get_next_entry でポインタが動いているので、毎回 input.read で OK
        wf.puts(input.read)
      end
      entrys << save_path
    end
  end
  # 解凍されたファイル名の配列を返す
  entrys
end


# 入力に.csv/出力に.csv を使用
def create_index(csv_file, txt_file)
  File.open(txt_file, 'w') do |file|
    # CSVファイルを１行ずつ取り出す
    CSV.foreach(csv_file, encoding: 'SJIS:UTF-8').with_index do |row, idx|
      # 必要になるであろう2行目(0,1,2)と6,7,8行目の情報で表示
      # with_indexで連番のidxの作成
      output_record = "#{idx} #{row[2]} #{row[6]} #{row[7]} #{row[8]}\n"
      puts output_record
      # fileにoutput_recordの値を書き出し
      file.write(output_record)
    end
  end
end

# uncompressの実行 -> 引数の値にzip_fileと解凍したいdirのpathを渡す
# zip_infoに解凍されたcsv_fileが入る
zip_info = uncompress('ken_all.zip', '.')

# create_indexを実行 
create_index(zip_info[0], 'sample.csv')