module MinifiedErb
  module Cell
    def template_options_for(*)
      super.merge!(minify: true)
    end
  end

  ::Cell::ViewModel.send(:prepend, Cell)
end
