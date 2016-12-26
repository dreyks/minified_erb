module MinifiedErb
  module Erubis
    def init_converter(properties = {})
      super
      @minify = properties[:minify]
    end

    def convert_input(src, input)
      pat = @pattern
      regexp = pat.nil? || pat == '<% %>' ? self.class.const_get('DEFAULT_REGEXP') : pattern_regexp(pat)
      pos = 0
      is_bol = true # is beginning of line
      input.scan(regexp) do |indicator, code, tailch, rspace|
        match = Regexp.last_match
        len = match.begin(0) - pos
        text = input[pos, len]
        pos = match.end(0)
        ch = indicator ? indicator[0] : nil
        lspace = ch == '=' ? nil : detect_spaces_at_bol(text, is_bol)

        MinifiedErb.html!(text) if @minify

        is_bol = rspace ? true : false

        rspace = nil if @minify

        add_text(src, text) if text && !text.empty?
        ## * when '<%= %>', do nothing
        ## * when '<% %>' or '<%# %>', delete spaces iff only spaces are around '<% %>'
        if ch == '=' # <%= %>
          rspace = nil if tailch && !tailch.empty?
          add_text(src, lspace) if lspace
          add_expr(src, code, indicator)
          add_text(src, rspace) if rspace
        elsif ch == '#' # <%# %>
          unless @minify
            n = code.count("\n") + (rspace ? 1 : 0)
            if @trim && lspace && rspace
              add_stmt(src, "\n" * n)
            else
              add_text(src, lspace) if lspace
              add_stmt(src, "\n" * n)
              add_text(src, rspace) if rspace
            end
          end
        elsif ch == '%' # <%% %>
          s = "#{lspace}#{@prefix ||= '<%'}#{code}#{tailch}#{@postfix ||= '%>'}#{rspace}"
          add_text(src, s)
        else # <% %>
          if @trim && lspace && rspace
            add_stmt(src, "#{lspace}#{code}#{rspace}")
          else
            add_text(src, lspace) if lspace
            add_stmt(src, code)
            add_text(src, rspace) if rspace
          end
        end
      end

      # rest = $' || input                        # ruby1.8
      rest = pos == 0 ? input : input[pos..-1] # ruby1.9
      if @minify
        rest.strip!
        rest.gsub!(/>\s*[\n\t]+\s*</mi, '><')
      end
      add_text(src, rest)
    end

    protected

    def detect_spaces_at_bol(text, is_bol)
      lspace = nil
      if text.empty?
        lspace = '' if is_bol
      elsif text[-1] == "\n"
        lspace = ''
      else
        rindex = text.rindex("\n")
        if rindex
          s = text[rindex + 1..-1]
          if s =~ /\A[ \t]*\z/
            lspace = s unless @minify
            # text = text[0..rindex]
            text[rindex + 1..-1] = ''
          end
        else
          if is_bol && text =~ /\A[ \t]*\z/
            # lspace = text
            # text = nil
            lspace = text.dup unless @minify
            text[0..-1] = ''
          end
        end
      end
      lspace
    end
  end

  ::Erubis::Eruby.send(:include, Erubis)
end
