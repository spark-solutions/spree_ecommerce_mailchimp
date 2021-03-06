module Spree
  module SpreeMailchimpEcommerce
    module OrderDecorator
      def self.prepended(base)
        base.before_update :create_mailchimp_cart, if: proc { email_changed? }
        base.state_machine.after_transition to: :complete, do: :after_create_jobs
      end

      def mailchimp_cart
        ::SpreeMailchimpEcommerce::Presenters::CartMailchimpPresenter.new(self).json
      end

      def mailchimp_order
        ::SpreeMailchimpEcommerce::Presenters::OrderMailchimpPresenter.new(self).json
      end

      def update_mailchimp_cart
        ::SpreeMailchimpEcommerce::UpdateOrderCartJob.perform_later(mailchimp_cart)
      end

      def create_mailchimp_cart
        ::SpreeMailchimpEcommerce::CreateOrderCartJob.perform_later(mailchimp_cart)
        update(mailchimp_cart_created: true)
      end

      private

      def after_create_jobs
        create_mailchimp_order
        delete_mailchimp_cart
      end

      def delete_mailchimp_cart
        ::SpreeMailchimpEcommerce::DeleteCartJob.perform_later(id)
      end

      def create_mailchimp_order
        ::SpreeMailchimpEcommerce::CreateOrderJob.perform_later(id)
      end
    end
  end
end
Spree::Order.prepend(Spree::SpreeMailchimpEcommerce::OrderDecorator)
