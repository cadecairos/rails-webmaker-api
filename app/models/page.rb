class Page < ActiveRecord::Base
  belongs_to :project

  serialize :styles, HashSerializer

  serialize :pages, HashSerializer

  validates_presence_of [:x, :y]
end
