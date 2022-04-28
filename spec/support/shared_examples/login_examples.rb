RSpec.shared_examples "login example" do
  before{get :index}
  
  it "show flash danger please login" do
    expect(flash[:alert]).to eq I18n.t("devise.failure.unauthenticated")
  end

  it {expect(response).to redirect_to("/users/sign_in")}
end
