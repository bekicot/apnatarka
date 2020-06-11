class OrderBroadcastJob < ApplicationJob
  queue_as :default

  def perform(order)
  	ActionCable.server.broadcast "order_channel", {
  		order: render_message(order)
  	}
    # Do something later
  end

  private
  def render_message(order)
  	Admin::OrderHistoriesController.render(
  		partial: 'order',
  		locals: {
  			order: order
  		}
  	)
  end
end
