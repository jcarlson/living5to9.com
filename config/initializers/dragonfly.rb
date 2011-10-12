require 'dragonfly/rails/images'

Dragonfly[:images].analyser.register(Dragonfly::Analysis::MetadataAnalyzer)

Dragonfly[:images].configure do |c|
  #c.url_format = "/:job.:format"
end