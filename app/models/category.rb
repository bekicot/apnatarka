class Category < ApplicationRecord
  has_attached_file :avatar, convert_options: {all: "-strip -interlace Plane -density 72 -quality 70 "}, processors: [:thumbnail, :paperclip_optimizer],
  styles: {
    medium: {
      geometry: '300x300#',
      paperclip_optimizer: {
        jhead: false, pngquant: false, optipng: false, jpegtran: false, svgo: false
      }
    }
  }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates_presence_of :title, :avatar, :description
  validates_uniqueness_of :title

  translates :title, :description
  globalize_accessors attributes: [:title, :description]

  default_scope { includes(:translations) }

  has_many :menu_items, dependent: :destroy
  has_many :chef_categories
  has_many :chefs, through: :chef_categories, source: :user
end
