require "rails_helper"

RSpec.describe EventsController, type: :controller do

  describe "GET events#index" do
    context "When when logged in" do
      let!(:user) {FactoryBot.create :user}
      before{sign_in(user)}
      it "success when render template index" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "when not logged in" do
      it "success when render template index" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
