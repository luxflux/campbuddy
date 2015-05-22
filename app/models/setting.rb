class Setting
  def self.camp_starts
    current_camp.starts
  end

  def self.camp_ends
    current_camp.ends
  end

  def self.registration_opens
    current_camp.registration_opens
  end

  def self.registration_open?
    Date.current >= registration_opens
  end

  def self.current_camp
    Camp.find_by_schema_name!(Apartment::Tenant.current)
  end
end
