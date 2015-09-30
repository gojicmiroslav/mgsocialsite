require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
	
	describe "#full_title" do
		it "should render full title" do
			expect(helper.full_title).to eq("MG Social Site")
			expect(helper.full_title("Help")).to eq("Help | MG Social Site")
		end
	end
end