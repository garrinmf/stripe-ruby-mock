require 'spec_helper'

shared_examples 'SKU API' do
  it "creates a stripe sku with a required" do
    sku = Stripe::SKU.create({
      inventory: {
        quantity: 50,
        type: "finite",
        value: "in_stock"
      },
      attributes: {
        size: "Medium"
      },
      currency: "usd",
      active: true
    })
    expect(sku.id).to match(/^test_sku/)
    expect(sku.active).to eq(true)
    expect(sku.attributes.size).to eq("Medium")
    expect(sku.inventory.quantity).to eq(50)
    expect(sku.inventory.type).to eq("finite")
    expect(sku.inventory.value).to eq("in_stock")
  end
end
