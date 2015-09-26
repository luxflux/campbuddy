module OfflineHelper
  def offline_cache_key
    events_max_updated_at = @events.maximum(:updated_at).try(:utc).try(:to_s, :number)
    numbers_max_updated_at = @emergency_numbers.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "offline/#{events_max_updated_at}-#{numbers_max_updated_at}"
  end
end
