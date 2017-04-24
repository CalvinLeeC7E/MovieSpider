class MovieStore < ActiveRecord::Base
  def have_update_douban
    self.update_attribute :dou_ban_update_time, Time.now
  end
end