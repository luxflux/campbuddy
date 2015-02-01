class Setting
  def self.camp_start
    @camp_start ||= '2015-02-07'.to_date
  end

  def self.camp_end
    @camp_end ||= '2015-02-14'.to_date
  end

  def self.open_registration
    @open_registration ||= camp_start - 1.day
  end

  def self.registration_open?
    Date.current >= open_registration
  end
end
