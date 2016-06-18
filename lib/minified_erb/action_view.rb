module MinifiedErb
  module ActionView
    def call(template)
      self.class.erb_implementation.new(
        template.source,
        escape: (self.class.escape_whitelist.include? template.type),
        trim: (self.class.erb_trim_mode == '-'),
        minify: (template.type == 'text/html')
      ).src
    end
  end

  ::ActionView::Template::Handlers::ERB.send(:prepend, ActionView)
end
