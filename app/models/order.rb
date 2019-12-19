class Order < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :address, optional: true
  belongs_to :location, optional: true
  has_many :order_items, dependent: :destroy

  after_create :generate_order_number

  enum payment_method: {debit_credit_card: 0, from_branch: 1}
  enum delivery_mode: [:carry_out, :delivery]
  enum ordered_as: [:registered_user, :guest_user]
  enum status: [:unpaid, :paid]

  scope :registered_orders, -> { (where(ordered_as: Order.ordered_as[:registered_user])) }
  scope :guest_orders, -> { (where(ordered_as: Order.ordered_as[:guest_user])) }

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_presence_of :first_name, :last_name, :email, :phone, :payment_method, :terms

  VAT_DISPLAY = "5%"
  VAT = 0.05

  def generate_order_number
    update_attribute(:order_number, Digest::SHA1.hexdigest("order-#{id}")[0..5])
  end
end
