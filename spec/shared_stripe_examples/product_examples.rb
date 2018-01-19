require 'spec_helper'

shared_examples 'Product API' do
  it "creates a stripe product with a required" do
    product = Stripe::Product.create({
      name: "Test Product",
    })
    expect(product.id).to match(/^test_product/)
    expect(product.name).to eq("Test Product")
    expect(product.active).to eq(false)
  end
end
