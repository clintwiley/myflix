require 'spec_helper'

describe SessionsController do
  describe 'GET #new' do
    it 'creates new user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end
  describe 'POST #create' do
    context 'needs standard params' do
      before(:each) do
        @alice_params = Fabricate.attributes_for(:user)
        @alice = User.create(@alice_params)
        post :create, user: @alice_params
      end
      it 'sets @user object correctly' do
        expect(assigns(:user).email).to eq(@alice_params[:email])
      end
      it 'returns user object is authentication passes' do
        obj = assigns(:user).authenticate(@alice_params[:password])
        expect(obj).to eq(@alice)
      end
      it 'returns false if authentication fails' do
        obj = assigns(:user).authenticate(@alice_params[:password] + 'sfdhdfh')
        expect(obj).to eq(false)
      end
      it 'sets the session[:user_id] to the user.id' do
        expect(session[:user_id]).to eq(@alice.id)
      end
      it 'displays flash[:success] if authentication is sucessful' do
        expect(flash[:success]).to be_present
      end
      it 'redirect_to home_path if authentication is complete' do
        expect(response).to redirect_to home_path
      end
    end
    context 'needs failing params' do
      before(:each) do
        @alice = Fabricate(:user)
        post :create, user: Fabricate.attributes_for(:user)
      end
      it 'displays flash[:danger] if authentication fails' do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
