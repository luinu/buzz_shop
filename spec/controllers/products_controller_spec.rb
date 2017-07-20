require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  let(:product) { Product.first }

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
end
