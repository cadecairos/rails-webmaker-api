class Project < ActiveRecord::Base

  @@VERSION = "1.0"

  belongs_to :user
  has_many :pages, dependent: :destroy

  serialize :metadata, HashSerializer

  store_accessor :metadata, :tags

  validates_presence_of [:title]

  before_save :safe_defaults
  before_save :extract_tags

  def to_json(options = nil)
    options ||= {}
    project = {
      id: self.id,
      remixed_from: self.remixed_from,
      version: self.version,
      featured: self.featured,
      tags: self.metadata["tags"]
    }

    project[:history] = {
      created_at: self.created_at,
      updated_at: self.updated_at,
      deleted_at: self.deleted_at
    }

    project[:author] = {
      id: self.user.id,
      username: self.user.username,
      created_at: self.user.created_at,
      updated_at: self.user.updated_at,
      staff: self.user.staff,
      moderator: self.user.moderator
    }

    project[:pages] = self.pages

    project
  end

  private

  def safe_defaults
    self.featured = false if featured.nil?
    self.description = '' if description.nil?
    self.version = @@VERSION
  end

  def extract_tags
    tags = self.description.scan(/#(\S+)/)
    tags[0].map! { |t| t.downcase }

    self.metadata = { tags: tags[0].uniq }
  end
end
