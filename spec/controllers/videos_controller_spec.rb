require 'spec_helper'

describe VideosController do
  describe "Get show" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq (video)
      end
    end
    context "with unauthorized users" do
      it "redirects to the sign in page" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
    describe "POST search" do
      it "sets @results for authenticated users" do
        session[:user_id] = Fabricate(:user).id
        futurama = Fabricate(:video, title: 'Futurama')
        post :search, search_term: 'rama'
        expect(assigns(:results)).to eq([futurama])
      end
    end
    it "redirects to signin page for unauth users" do
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
  end
end
