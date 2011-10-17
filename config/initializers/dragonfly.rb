# setup dragonfly configuration for Rails
require 'dragonfly/rails/images'

# Add some analysers/processors that I wrote
Dragonfly[:images].analyser.register(Dragonfly::Analysis::MetadataAnalyzer)
Dragonfly[:images].processor.register(WatermarkProcessor)

Dragonfly[:images].configure do |c|
  c.job :watermark do |size|
    process :thumb, size
    process :watermark
  end
end
