require 'minified_erb/converter'

module MinifiedErb
  module Erubis
    include Converter

    def init_converter(properties = {})
      super
      init_minifier(properties)
    end
  end

  ::Erubis::Eruby.send(:include, Erubis)
end
