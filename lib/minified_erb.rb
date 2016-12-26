require 'minified_erb/version'

module MinifiedErb
  def self.html(input)
    input.clone.tap do |cloned|
      html!(cloned)
    end
  end

  def self.html!(input)
    input.gsub!(/>\s*[\n\t]+\s*</mi, '><')
    input.gsub!(/>\s*$/mi, '>')
    input.gsub!(/^\s*</mi, '<')
  end
end

require 'minified_erb/erubis' if defined? Erubis
require 'minified_erb/action_view' if defined? ActionView

require 'minified_erb/erbse' if defined? Erbse
require 'minified_erb/cell' if defined? Cell

