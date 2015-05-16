class Camp < ActiveRecord::Base
  belongs_to :organization

  before_validation :set_schema_name
  after_create :create_tenant

  validates :schema_name, presence: true
  validates :name, presence: true
  validates :subdomain, presence: true
  validates :organization, presence: true

  def set_schema_name
    self.schema_name = "#{subdomain}.#{organization.domain}".gsub('.', '_')
  end

  def create_tenant
    Apartment::Tenant.create(schema_name)
  end
end
