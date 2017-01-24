module MinifiedErb
  module Erbse
    class NewlinesFilter < Temple::Filter
      def on_static(value)
        [:static, MinifiedErb.html(value)]
      end
    end

    ::Erbse::Engine.send(:after, ::Erbse::BlockFilter, NewlinesFilter)
  end
end

