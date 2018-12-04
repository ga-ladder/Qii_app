module ApplicationHelper
  def qiita_markdown(markdown)
    processor = Qiita::Markdown::Processor.new(hostname: "example.com")
    processor.filters << HTML::Pipeline::ImageMaxWidthFilter
    processor.filters << HTML::Pipeline::EmojiFilter
    processor.call(markdown)[:output].to_s.html_safe
  end
end
