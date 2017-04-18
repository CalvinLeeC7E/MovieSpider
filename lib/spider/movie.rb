module Spider
  class Movie
    attr_accessor :ori_title, :year, :title, :des, :resolution, :language, :resource_addr, :img_cover, :pre_img

    def initialize(title, resource_addr=nil)
      self.ori_title = title
      self.resource_addr = resource_addr
      init()
    end

    def init
      match_str = self.ori_title.match(/([0-9]{4})(.*)(\《.*\》)(.*)(HD|BD)(.*)/)
      return unless match_str
      self.year = match_str[1]
      self.des = match_str[2].gsub('年', '') rescue ''
      self.title = match_str[3].gsub(/\《|\》/, '') rescue ''
      self.resolution = match_str[5]
      self.language = match_str[6]
    end

    def to_s
      [self.year, self.des, self.title, self.resolution, self.language].join(' - ')
    end

    def to_json_data
      {
          year: self.year, title: self.title, des: self.des,
          resolution: self.resolution, language: self.language,
          img_cover: self.img_cover, pre_img: self.pre_img,
          resource_addr: self.resource_addr
      }
    end

    def to_store
      begin
        MovieStore.create(self.to_json_data)
      rescue
      end
    end
  end
end