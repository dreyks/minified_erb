require 'erubis'
require 'erbse'
require 'minified_erb'

RSpec.describe Erubis::Eruby do
  describe '#result' do
    subject(:result) { described_class.new(input, minify: true).result }

    context 'plain text' do
      let(:input) do
        <<-HEREDOC
<div>
  <span></span>
  <span></span>
</div>
        HEREDOC
      end

      it { is_expected.to eq '<div><span></span><span></span></div>' }
    end

    context 'erb statements' do
      let(:input) do
        <<-HEREDOC
<div>
  <span></span>
  <span></span>
</div>
        HEREDOC
      end

      it { is_expected.to eq '<div><span></span><span></span></div>' }
    end

    context 'erb cycles' do
      let(:input) do
        <<-HEREDOC
<div>
  <% 3.times do %>
    <span></span>
  <% end %>
</div>
        HEREDOC
      end

      it { is_expected.to eq '<div><span></span><span></span><span></span></div>' }
    end

    context 'erb cycles iwth statements' do
      let(:input) do
        <<-HEREDOC
<div>
  <% 3.times do %>
    <% true %>
    <span></span>
  <% end %>
</div>
        HEREDOC
      end

      it { is_expected.to eq '<div><span></span><span></span><span></span></div>' }
    end

    context 'erb expression' do
      let(:input) do
        <<-HEREDOC
<div>
  <span></span>
  <%= 123 %>
  <%= 456 %>
  <span></span>
</div>
        HEREDOC
      end

      it { is_expected.to eq '<div><span></span>123456<span></span></div>' }
    end

    context 'inline erb expression' do
      let(:input) do
        <<-HEREDOC
<div class="class1 <%= 'class2' %> <%= 'class3' %>">
  <span></span>
  <span></span>
</div>
        HEREDOC
      end

      it { is_expected.to eq '<div class="class1 class2 class3"><span></span><span></span></div>' }
    end

    context 'indents' do
      let(:input) do
        <<-HEREDOC
    <div>
      <% if true %>
        <span></span>
      <% end %>
    </div>
        HEREDOC
      end

      it { is_expected.to eq '<div><span></span></div>' }
    end
  end
end
