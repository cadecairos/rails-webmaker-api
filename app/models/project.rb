class Project < ActiveRecord::Base

  @@VERSION = "1.0"

  belongs_to :user

  serialize :metadata, HashSerializer

  store_accessor :metadata, :tags

  validates_presence_of [:title]

  before_save :safe_defaults

  private

  def safe_defaults
    self.featured = false if featured.nil?
    self.description = '' if description.nil?
    self.version = @@VERSION
  end
end
