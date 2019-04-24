require "spec_helper"

describe Spree::Product, type: :model do
  subject { build(:product) }

  shared_examples "mailchimp" do
    it "schedules mailchimp notification on product create" do
      subject.save!

      expect(SpreeMailchimpEcommerce::CreateProductJob).to have_been_enqueued.with(subject.id)
    end

    it "schedules mailchimp notification on product update" do
      subject.save!
      subject.update!(name: "new product")

      expect(SpreeMailchimpEcommerce::UpdateProductJob).to have_been_enqueued.with(subject.id)
    end
  end

  shared_examples ".mailchimp_product" do
    it "returns valid schema" do
      expect(subject.mailchimp_product).to match_json_schema("product")
    end
  end

  context 'product without dependencies' do
    it_behaves_like 'mailchimp'
    it_behaves_like '.mailchimp_product'
  end

  context 'product with image' do
    let(:image) { create(:image) }
    before { subject.images << image }

    it_behaves_like 'mailchimp'
    it_behaves_like '.mailchimp_product'
  end

  context 'product with variant' do
    let(:variant) { build(:variant) }
    before { subject.variants << variant }

    it_behaves_like 'mailchimp'
    it_behaves_like '.mailchimp_product'
  end
end
