require 'rails_helper'
require 'faker'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe User, type: :model do

  describe 'Validations' do

    before :each do
      @password = Faker::Bitcoin.address
      @user = User.new({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: @password,
        password_confirmation: @password
      })
    end

    it 'is valid with all attributes' do
      expect(@user).to be_valid
    end

    it 'is valid with a first name' do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it 'is valid with a last name' do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it 'is must have password and password confirmation fields
    ' do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end

    it 'should have matching password and password confirmation fields' do
      @user.password = 'pikachu'
      expect(@user).to_not be_valid
    end

    it 'is not valid with already used emails' do
      @user.email = "dood.com"
      @user.save
      @user2 = User.create({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: "doOD.com",
        password: @password,
        password_confirmation: @password
      })
      expect(@user2.errors).to include(:email)
    end

    it 'is valid with an email' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'should have a password of at least 5 characters' do
      @user.password = 'moo'
      @user.password_confirmation = 'moo'
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do

    before :each do
      @password = Faker::Bitcoin.address
      @email = Faker::Internet.email
      @user = User.new({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: @email,
        password: @password,
        password_confirmation: @password
      })
    end

    it 'should return nil if password and email are not in database' do
      @user.save
      expect(User.authenticate_with_credentials("bob", "marley")).to equal(nil)
    end

    it 'should return user information if password and email are in database' do
      @user.save
      expect(User.authenticate_with_credentials(@email, @password)).to be_truthy
    end

    it 'should return user information if email has additional spaces' do
      @user.save
      expect(User.authenticate_with_credentials("  #{@email}  ", @password)).to be_truthy
    end

    it 'should return user information if email is upper case' do
      @user.email = "rawr.com"
      @user.save
      @test = "RAWR.com"
      expect(User.authenticate_with_credentials(@test, @password)).to be_truthy
    end

  end

end
