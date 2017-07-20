require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { Category.first }

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { id: category.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :show
    end
  end
end
