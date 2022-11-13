require "inifile"

class Search < ApplicationRecord
  def self.searchApi(keyWord = nil)
    # 設定ファイル読み込み
    ini = IniFile.load("setting.conf")

    # 検索未入力の場合はデフォルトキーワードで検索(設定しないとエラーになる)
    if keyWord.nil? or keyWord.empty?
      keyWord = ini["api"]["defaultKeyWord"]
    end

    require "google/apis/customsearch_v1"

    # Doc: https://googleapis.dev/ruby/google-api-client/latest/Google/Apis/CustomsearchV1/CustomSearchAPIService.html
    searcher = Google::Apis::CustomsearchV1::CustomSearchAPIService.new
    searcher.key = ini["api"]["key"]  # APIキー
    id = ini["api"]["id"]             # 検索エンジンID

    # Doc: https://googleapis.dev/ruby/google-api-client/latest/Google/Apis/CustomsearchV1/Search.html
    results = searcher.list_cses(cx: id, q: keyWord)

    # Doc: https://googleapis.dev/ruby/google-api-client/latest/Google/Apis/CustomsearchV1/Search/SearchInformation.html
    results.search_information.total_results

    # Doc: https://googleapis.dev/ruby/google-api-client/latest/Google/Apis/CustomsearchV1/Result.html
    items = results.items

    kondateList = []
    items.each { |item|
      kodatate = { "title" => item.title, "snippet" => item.snippet, "link" => item.link, "image" => item.pagemap["cse_image"].first["src"] }
      kondateList.push(kodatate)
    }

    # シャッフルして３件のみ表示
    kondateList.shuffle!
    kondateList.slice!(3, kondateList.length - 1)
    pp kondateList.length

    return kondateList
  end
end
