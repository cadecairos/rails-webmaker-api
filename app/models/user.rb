class User < ActiveRecord::Base
  has_many :projects, dependent: :destroy

  validates :username,
            presence: true,
            length: { maximum: 20 }

  after_initialize :init

  private

  def init
    self.moderator ||= false
    self.staff ||= false
  end
end
