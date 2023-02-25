require 'rails_helper'

RSpec.describe "/expenses", type: :request do
  
  let(:user) do
    User.create(name: 'Recilah', email: 'recillah@gmail.com', password: '123456', password_confirmation: '123456')
  end

  before do
    # stub the authenticate_user! method
    allow_any_instance_of(ExpensesController).to receive(:authenticate_user!).and_return(true)
    allow_any_instance_of(ExpensesController).to receive(:current_user).and_return(user)
  end

  let(:category) do
    Category.create(name: 'Food', author_id: user.id)
  end

  describe "GET /index" do
    it "renders a successful response" do
      Expense.create!(name: 'pizza', amount: 5.2, user_id: user.id)
      get expenses_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      expense = Expense.create!(name: 'pizza', amount: 5.2, user_id: user.id)
      get expense_url(expense)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_expense_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      expense = Expense.create!(name: 'pizza', amount: 5.2, user_id: user.id)
      get edit_expense_url(expense)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Expense" do
        expect {
          post expenses_url, params: { expense: {name: 'pizza', amount: 5.2 } }
        }.to change(Expense, :count).by(1)
      end

      it "redirects to the created expense" do
        post expenses_url, params: { expense: {name: 'pizza', amount: 5.2 } }
        expect(response).to redirect_to(expense_url(Expense.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Expense" do
        expect {
          post expenses_url, params: { expense: {name: '', amount: 5.2 } }
        }.to change(Expense, :count).by(0)
      end
    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post expenses_url, params: { expense: {name: '', amount: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:expense) do 
        Expense.create(name: 'pizza', amount: 5.2, user_id: user.id)
      end

      it "updates the requested expense" do
        expense = Expense.create!(name: 'pizza', amount: 5.2, user_id: user.id)
        patch expense_url(expense), params: { expense: {name: 'Coffee', amount: 1.6 }  }
        expense.reload
        expect(expense.name).to eq 'Coffee'
      end

      it "redirects to the expense" do
        expense = Expense.create!(name: 'pizza', amount: 5.2, user_id: user.id)
        patch expense_url(expense), params: { expense: {name: 'Coffee', amount: 1.6 } }
        expense.reload
        expect(response).to redirect_to(expense_url(expense))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        expense = Expense.create!(name: 'pizza', amount: 5.2, user_id: user.id)
        patch expense_url(expense), params: { expense: {name: '', amount: 1.6 } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested expense" do
      expense = Expense.create!(name: 'pizza', amount: 5.2, user_id: user.id)
      expect {
        delete expense_url(expense)
      }.to change(Expense, :count).by(-1)
    end

    it "redirects to the expenses list" do
      expense = Expense.create!(name: 'pizza', amount: 5.2, user_id: user.id)
      delete expense_url(expense)
      expect(response).to redirect_to(expenses_url)
    end
  end
end
