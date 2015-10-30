require 'rails_helper'

RSpec.describe Micropost, type: :model do
  
	context "validation" do
		
		before do
			@user = FactoryGirl.create(:user) 
			#@micropost = Micropost.new(content: "Lorem Ipsum", user_id: @user.id)

			# thic can because of associations belongs_to and nas_many
			@micropost =@user.microposts.build(content: "Lorem Ipsum")
		end

		it "should be valid" do
	  	@micropost.valid?
	  	expect(@micropost.errors.size).to eq(0)
	  end

	  it { should validate_presence_of :user_id }
	  it { should validate_presence_of :content }
	end

	context "ordering" do
		#fixtures :users
		fixtures :microposts

		it "should" do
			expect(Micropost.first).to eq(microposts(:most_recent))	
		end

	end

end
