class MenuItem < ApplicationRecord

  @@cart_joiner = "menu_item_"
  @@quantity    = 1

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
  validates_uniqueness_of :title

  belongs_to :category
  has_many :order_items

  translates :title, :description
  globalize_accessors attributes: [:title, :description]

  default_scope { includes(:translations) }

  def self.item_to_add_in_cart(menu_item, quantity=nil)
    if quantity.nil?
      {"#{@@cart_joiner}#{menu_item}" => @@quantity}
    else
      {"#{@@cart_joiner}#{menu_item}" => quantity}
    end
  end

  def self.get_item_from_cart(key)
    key.sub(@@cart_joiner, '')
  end

  def self.item_key_for_cart(menu_item)
    "#{@@cart_joiner}#{menu_item}"
  end

  def self.special_request_to_add_in_cart(menu_item, message)
    {"#{@@cart_joiner}#{menu_item}" => message}
  end

  def self.special_request(order_item)
    if order_item.present? && order_item.special_request.present?
      order_item.special_request
    else
      "N/A"
    end
  end

end
