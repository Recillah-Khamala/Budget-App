require 'rails_helper'

RSpec.describe "/categories", type: :request do
  
  let(:user) do
    User.create(name: 'Recilah', email: 'recillah@gmail.com', password: '123456', password_confirmation: '123456')
  end

  before do
    # stub the authenticate_user! method
    allow_any_instance_of(CategoriesController).to receive(:authenticate_user!).and_return(true)
    allow_any_instance_of(CategoriesController).to receive(:current_user).and_return(user)
  end
  

  describe "GET /index" do
    it "renders a successful response" do
      Category.create!(name: 'Books', icon: 'books.png', user_id: user.id)
      get categories_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      category = Category.create!(name: 'Books', icon: 'books.png', user_id: user.id)
      get category_url(category)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_category_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      category = Category.create!(name: 'Books', icon: 'books.png', user_id: user.id)
      get edit_category_url(category)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Category" do
        expect {
          post categories_url, params: { category: { name: 'Books', icon: 'books.png' } }
        }.to change(Category, :count).by(1)
      end
    
  

      it "redirects to the created category" do
        post categories_url, params: { category: { name: 'Books', icon: 'books.png' } }
        expect(response).to redirect_to(category_url(Category.last))
      end
    end
  

    context "with invalid parameters" do
      it "does not create a new Category" do
        expect {
          post categories_url, params: { category: { name: '', icon: 'books.png' } }
        }.to change(Category, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post categories_url, params: { category: { name: 'Books', icon: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested category" do
      category = Category.create!(name: 'Books', icon: 'books.png', user_id: user.id)
      expect {
        delete category_url(category)
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create!(name: 'Books', icon: 'books.png', user_id: user.id)
      delete category_url(category)
      expect(response).to redirect_to(categories_url)
    end
  end
end
