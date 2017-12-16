require 'json'
require 'google/cloud/language'
require_relative 'analyzer'

Dir['./corpora/*.html'].each do |file|
  text_content = File.read(file)

  analyzer = Analyzer.new(text_content, type: :HTML)

  File.open "./analysis/#{File.basename(file, '.html')}.json", 'w+' do |out|
    out << JSON.pretty_generate({
      categories: analyzer.classified_categories,
      entities: analyzer.analyzed_entities,
      sentiment: analyzer.analyzed_sentiment
    })
  end
end
