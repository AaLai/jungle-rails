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
        price_cents: Faker::Number.number(4)
      })
    end

    it "is valid with valid attributes" do
      expect(@product).to be_valid
    end

    it "is not valid without a name" do
      expect(@product).to be_valid
    end

    it "is not valid without a price" do
      expect(@product).to be_valid
    end

    it "is not valid without a quantity" do
      expect(@product).to be_valid
    end

    it "is not valid without a category" do
      expect(@product).to be_valid
    end

  end

end
