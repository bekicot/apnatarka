class Order < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :address, optional: true
  has_many :rider
  belongs_to :location, optional: true
  has_many :order_items, dependent: :destroy
  has_many :order_special_items, dependent: :destroy
  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :order_special_items, reject_if: :all_blank, allow_destroy: true
  after_create :generate_order_number

  enum payment_method: { home_delivery: 1}
  enum delivery_mode: [:carry_out, :delivery]
  enum ordered_as: [:registered_user, :guest_user, :order_from_branch ]
  enum status: [:unpaid, :paid, :cash_on_delivery]
  enum order_status: [:pending, :accept, :reject, :ready, :given_to_rider]

  scope :registered_orders, -> { (where(ordered_as: Order.ordered_as[:registered_user])) }
  scope :guest_orders, -> { (where(ordered_as: Order.ordered_as[:guest_user])) }
  scope :from_branch_orders, -> { (where(ordered_as: Order.ordered_as[:order_from_branch])) }

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_presence_of :first_name, :email, :phone, :payment_method, :terms

  VAT_DISPLAY = "5%"
  VAT = 0.05

  def generate_order_number
    update_attribute(:order_number, Digest::SHA1.hexdigest("order-#{id}")[0..5])
  end

  def time_diff(start_time, end_time)
    seconds_diff = (30.minutes -  (end_time - start_time )).to_i

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
    # or, as hagello suggested in the comments:
    # '%02d:%02d:%02d' % [hours, minutes, seconds]
  end

  after_create_commit {
    OrderBroadcastJob.perform_later(self)
  }
end
