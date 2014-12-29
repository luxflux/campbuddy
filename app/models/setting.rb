class Setting
  def self.camp_start
    @camp_start ||= '2015-02-07'.to_date
  end

  def self.camp_end
    @camp_end ||= '2015-02-14'.to_date
  end
end
