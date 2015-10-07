require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "validation" do
  	before do
  		@user = User.new(name: "Example User", email: "user@example.com",
  										 password: "foobar123", password_confirmation: "foobar123")
  	end

	  it "should be valid" do
	  	@user.valid?
	  	expect(@user.errors.size).to eq(0)
	  end

	  it { should validate_presence_of :name }
	  it { should validate_presence_of :email }
	  it { should validate_length_of(:name).is_at_most(50) }
	  it { should validate_uniqueness_of(:email).case_insensitive }
	  it { should validate_length_of(:password).is_at_least(5) }

	  # Ovde ima bag
	  xit 'email with invalid format is invalid' do
	  	invalid_addresses = %w[ user@example,com user_at_foo.org user@example. foo@bar_baz.com 
														  foo@bar+baz.com]
			
			invalid_addresses.each do |invalid_address|									 
		  	user = User.new(name: 'Example User', email: invalid_address,
		  									password: "foobar123", password_confirmation: "foobar123")
  			user.save
  			expect(user.errors.messages[:email]).to include(["is invalid"])
  		end
		end

		it "accept valid email address" do
			valid_addresses = %w[ user@example.com USER@foo.COM A_US_ER@foo.bar.org 
														first.last@foo.jp alice+bob@baz.cn]
			valid_addresses.each do |valid_address|
				user = User.new(name: 'Example User', email: valid_address,
												password: "foobar123", password_confirmation: "foobar123")
  			user.save
				expect(user.errors.get(:email)).to be_nil
			end										
		end

	end
end

