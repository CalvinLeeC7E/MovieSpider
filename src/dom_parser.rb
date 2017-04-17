class DOMParser
  class << self
    def pages_parser(dom)
      dom.css('.co_content8 .x option')
    end

    def movie_parser(dom)
      dom.css('.co_content8 ul table a')
    end

    def movie_detail_parser(dom)
      dom.css('#Zoom img')
    end
  end
end