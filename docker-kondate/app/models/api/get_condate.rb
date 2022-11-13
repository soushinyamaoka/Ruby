class GetCondate
  #!/usr/bin/env ruby
  require "google/apis/customsearch_v1"

  API_KEY = ""
  CSE_ID = ""

  searcher = Google::Apis::CustomsearchV1::CustomsearchService.new
  searcher.key = API_KEY

  print "QUERY> "
  query = gets.chomp

  results = searcher.list_cses(query, cx: CSE_ID)
  items = results.items
  pp items.map { |item| { title: item.title, link: item.link } }
end
