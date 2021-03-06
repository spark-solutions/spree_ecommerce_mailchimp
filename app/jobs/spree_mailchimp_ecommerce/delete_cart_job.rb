# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteCartJob < ApplicationJob
    def perform(order_id)
      order = Spree::Order.find(order_id)

      gibbon_store.carts(order.number).delete
    end
  end
end
