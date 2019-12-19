module DeliveryHelper

  def payment_method_translation(method)
    if Order.payment_methods[method] == 0
      t('delivery.debited_credited')
    elsif Order.payment_methods[method] == 1
      t('delivery.picked_from_branch')
    end
  end

  def special_request_message(menu_item)
    if session[:special_request]&.has_key?(MenuItem.item_key_for_cart(menu_item))
      key_to_find = MenuItem.item_key_for_cart(menu_item)
      session[:special_request][key_to_find]
    end
  end

  def clear_all_sessions
    %i[address delivery_details cart special_request delivery_time].each{|x| session.delete(x)}
  end
end
