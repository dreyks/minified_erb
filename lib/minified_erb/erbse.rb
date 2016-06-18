require 'minified_erb/converter'

module MinifiedErb
  module Erbse
    include Converter

    def init_converter!(properties = {})
      super
      init_minifier(properties)
    end

    # in Erbse add_* methods are defined on +generator+
    def method_missing(name, *args, &block)
      generator.respond_to?(name) ? generator.send(name, *args, &block) : super
    end

    def respond_to_missing?(name, include_private = false)
      generator.respond_to?(name) || super
    end
  end

  ::Erbse::Basic::Converter.prepend Erbse
end
