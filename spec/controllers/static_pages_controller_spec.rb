require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do

  describe "GET static_pages#index" do
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
        expect(response).to render_template :landing_page
      end
    end
  end
end
