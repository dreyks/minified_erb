require 'minified_erb/version'

module MinifiedErb
end

require 'minified_erb/erubis' if defined? Erubis
require 'minified_erb/action_view' if defined? ActionView
require 'minified_erb/erbse' if defined? Erbse
require 'minified_erb/cell' if defined? Cell
