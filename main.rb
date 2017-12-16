require "google/cloud/language"
require_relative 'analyzer'

text_content = "Lawrence of Arabia' is a highly rated film biography about British Lieutenant T. E. Lawrence. Peter O'Toole plays Lawrence in the film. I think this film is terrible."

analyzer = Analyzer.new(text_content)

p analyzer.classified_categories
p analyzer.analyzed_entities
p analyzer.analyzed_sentiment
