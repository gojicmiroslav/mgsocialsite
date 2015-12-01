require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "GET #home" do
    let(:user){ FactoryGirl.create(:user) }

    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end

    context "User Not Logged In" do
      it "render home template and front layout" do
        get :home
        expect(response).to render_template(:home, layout: "front_layout")
      end
    end

    context "User Logged In" do
      it "render home template and front layout" do
        sign_in user
        get :home
        expect(response).to render_template(:home, layout: "application")
      end
    end
  end

  describe "GET #help" do
    it "returns http success" do
      get :help
      expect(response).to have_http_status(:success)
    end

    it "render home template and static layout" do
      get :help
      expect(response).to render_template(:help, layout: "static_layout")
    end
  end

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end

    it "render about template and static layout" do
      get :about
      expect(response).to render_template(:about, layout: "static_layout")
    end
  end

  describe "GET #contact" do
    it "returns http success" do
      get :contact
      expect(response).to have_http_status(:success)
    end

    it "render contact template" do
      get :contact
      expect(response).to render_template(:contact, layout: "static_layout")
    end
  end

end
