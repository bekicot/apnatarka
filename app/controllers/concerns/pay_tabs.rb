require 'net/http'
require 'uri'
require 'socket'

module PayTabs
  extend ActiveSupport::Concern

  def payment_integration(order)
    uri          = URI.parse('https://www.paytabs.com/apiv2/validate_secret_key')
    http         = Net::HTTP.new(uri.host, uri.port)
    request      = Net::HTTP::Post.new(uri.request_uri)
    http.use_ssl = true
    request.set_form_data({merchant_email: ENV['MERCHANT_EMAIL'], secret_key: ENV['SECRET_KEY']})
    response     = http.request(request)

    create_pay_page(order) if response.body.include?('valid')
  end

  def create_pay_page(order)
    merchant_email  = ENV['MERCHANT_EMAIL']
    secret_key      = ENV['SECRET_KEY']
    site_url        = root_url
    return_url      = paytabs_callback_delivery_index_url(order: order.id)
    title           = order.order_number
    cc_first_name   = order&.user&.first_name || params[:order][:first_name]
    cc_last_name    = order&.user&.last_name || params[:order][:last_name]
    cc_phone_number = '+966'
    phone_number    = order&.user&.phone || params[:order][:phone]
    email           = order&.user&.email || params[:order][:email]
    ip_customer     = request.remote_ip
    ip_merchant     = Socket.ip_address_list.detect{|intf| intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast? and !intf.ipv4_private?}.try(:ip_address)
    products_per_title, unit_price, quantity = Array.new(3) { [] }
    total = 0

    order.order_items.each do |order_item|
      total = total + (order_item.quantity * order_item.menu_item.price)
      products_per_title << order_item.menu_item.title
      unit_price         << order_item.menu_item.price
      quantity           << order_item.quantity
    end

    sum_of_quantity    = quantity.sum
    products_per_title = products_per_title.join(' || ')
    unit_price         = unit_price.join(' || ')
    quantity           = quantity.join(' || ')
    other_charges      = order.sub_total - total
    amount             = order.sub_total
    discount           = 0

    billing_address    = order.address.direction.first(60)
    state              = order.state
    city               = order.city
    postal_code        = order.post_code
    country            = 'SAU'
    currency           = 'SAR'
    msg_lang           = I18n.locale == :en ? 'English' : 'Arabic'
    cms_with_version   = "#{Rails.name} #{Rails.version}"

    uri                = URI.parse('https://www.paytabs.com/apiv2/create_pay_page')
    http               = Net::HTTP.new(uri.host, uri.port)
    request            = Net::HTTP::Post.new(uri.request_uri)
    http.use_ssl       = true
    request.set_form_data({
                           merchant_email: merchant_email, secret_key: secret_key,
                           site_url: site_url, return_url: return_url, title: title,
                           cc_first_name: cc_first_name, cc_last_name: cc_last_name,
                           cc_phone_number: cc_phone_number, phone_number: phone_number,
                           email: email, products_per_title: products_per_title,
                           unit_price: unit_price, quantity: quantity, other_charges: other_charges,
                           amount: amount, discount: discount, currency: currency,
                           reference_no: title, ip_customer: ip_customer,
                           ip_merchant: ip_merchant, billing_address: billing_address,
                           state: state, city: city, postal_code: postal_code, country: country,
                           shipping_firt_name: cc_first_name,
                           shipping_last_name: cc_last_name, address_shipping: billing_address,
                           state_shipping: state, city_shipping: city,
                           postal_code_shipping: postal_code, country_shipping: country,
                           msg_lang: msg_lang, cms_with_version: cms_with_version
                         })
    response = http.request(request)
    resp     = JSON.parse(response.body)
    path     = resp['payment_url']
    redirect_to path
  end
end
