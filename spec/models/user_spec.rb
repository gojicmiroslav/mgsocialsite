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

	context "destroy dependent micropost" do
		before do
		 @user = FactoryGirl.create(:user)
		end

		it "should destroy assosiated micropost" do
			#@user.save
			@user.microposts.create(content: "Lorem Ipsum")

			expect { @user.destroy }.to change{ Micropost.count }.by(-1)
		end
	end

	context "follow and unfollow" do
		before do
	 		@user = FactoryGirl.create(:user)
	 		@other_user = FactoryGirl.create(:other_user)
		end

		it "should follow and unfollow user" do
			expect(@user.following?(@other_user)).to be false 
			@user.follow(@other_user)
			expect(@user.following?(@other_user)).to be true 
			# @other-user's followers should include @user
			expect(@other_user.followers.include?(@user)).to be true
			@user.unfollow(@other_user)
			expect(@user.following?(@other_user)).to be false 
			# @other-user's followers should NOT include @user
			expect(@other_user.followers.include?(@user)).to be false
		end
	end

	context "feed" do
		fixtures :users
		fixtures :microposts
		fixtures :relationships

		let(:miroslav){ users(:miroslav) }
		let(:archer){ users(:archer) }
		let(:lana){ users(:lana) }
		
		it "should have the right posts" do
			# Posts from followed user
			lana.microposts.each do |post_following|
				expect(miroslav.feed).to include(post_following)
			end

			# Posts from self
			miroslav.microposts.each do |post_self|
				expect(miroslav.feed).to include(post_self)
			end

			# Posts from unfollowed user
			archer.microposts.each do |post_unfollowed|
				expect(miroslav.feed).not_to include(post_unfollowed)
			end
		end
	end

end

