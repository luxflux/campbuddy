class Camp < ActiveRecord::Base
  belongs_to :organization

  before_validation :set_schema_name
  after_create :create_tenant

  validates :schema_name, presence: true
  validates :name, presence: true
  validates :subdomain, presence: true
  validates :organization, presence: true
  validates :welcome_text, presence: true
  validates :invitation_mail, presence: true

  validates :starts, presence: true
  validates :ends, presence: true
  validates :hashtag, presence: true
  validates :registration_opens, presence: true
  validates_datetime :starts, before: ->(event) { event.ends }
  validates_datetime :ends, after: ->(event) { event.starts }

  def set_schema_name
    self.schema_name = "#{subdomain}.#{organization.domain}".gsub('.', '_')
  end

  def create_tenant
    Apartment::Tenant.create(schema_name)
  end

  def registration_open?
    DateTime.current >= registration_opens
  end

  def self.current
    @camp = Camp.find_by_schema_name!(Apartment::Tenant.current)
  end
end
