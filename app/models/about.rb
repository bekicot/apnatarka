class About < ApplicationRecord
  translates :heading, :description
  globalize_accessors attributes: [:heading, :description]

  validates_presence_of :heading, :description

  scope :active, -> { where(is_active: true)}
  default_scope { includes(:translations) }
end
