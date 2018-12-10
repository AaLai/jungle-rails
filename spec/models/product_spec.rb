require 'rails_helper'
require 'faker'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    before :each do
      @category = Category.new(name: Faker::Lorem.word)
      @product = @category.products.new({
        name: Faker::Name.name,
        description: Faker::Hipster.paragraph,
        quantity: Faker::Number.number(2),
        price: Faker::Number.number(4)
      })
    end

    it "is valid with valid attributes" do
      expect(@product).to be_valid
    end

    it "is not valid without a name" do
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it "produces an error when saved without a name" do
      @product.name = nil
      @product.save
      expect(@product.errors).to include(:name)
    end

    it "is not valid without a price" do
      @product.price = nil
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end

    it "produces an error when saved without a price" do
      @product.price = nil
      @product.price_cents = nil
      @product.save
      expect(@product.errors).to include(:price || :price_cents)
    end

    it "is not valid without a quantity" do
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end

    it "is not valid without a category" do
      @product.category = nil
      expect(@product).to_not be_valid
    end

  end

end
