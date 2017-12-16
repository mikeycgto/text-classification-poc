class Analyzer
  def initialize(text_or_html, type: :PLAIN_TEXT)
    @language = Google::Cloud::Language.new

    @corpus = text_or_html
    @corpus_type = type
  end

  def classified_categories
    @classified_categories ||= request_text_classification
  end

  def analyzed_entities
    @analyzed_entities ||= request_entity_analysis
  end

  def analyzed_sentiment
    @analyzed_sentiment ||= request_sentiment_analysis
  end

  private

  attr_reader :language, :corpus, :corpus_type

  def request_text_classification
    response = language.classify_text content: corpus, type: corpus_type
    response.categories.map do |category|
      { name: category.name, confidence: category.confidence }
    end
  end

  def request_entity_analysis
    response = language.analyze_entities content: corpus, type: corpus_type
    response.entities.map do |entity|
      { name: entity.name, type: entity.type }
    end
  end

  def request_sentiment_analysis
    response = language.analyze_sentiment content: corpus, type: corpus_type
    doc_sentiment = response.document_sentiment

    { sentiment: doc_sentiment.score, magnitude: doc_sentiment.magnitude }.tap do |result|
      result[:sentences] = response.sentences.map do |sentence|
        sentiment = sentence.sentiment

        { sentence: sentence.text.content, score: sentiment.score, magnitude: sentiment.magnitude }
      end
    end
  end
end
