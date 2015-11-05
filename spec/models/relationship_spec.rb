require 'rails_helper'

RSpec.describe Relationship, type: :model do
  
	context "validation" do
		
		before do
			@relationship = FactoryGirl.create(:relationship)
		end

		it "should be valid" do
	  	@relationship.valid?
	  	expect(@relationship.errors.size).to eq(0)
	  end

	  it { should belong_to(:follower).class_name('User') }
  	it { should belong_to(:followed).class_name('User') }

  	it { should validate_presence_of :follower_id }
  	it { should validate_presence_of :followed_id }
	end

end
