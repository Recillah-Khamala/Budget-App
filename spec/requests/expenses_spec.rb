require 'rails_helper'

RSpec.describe '/expenses', type: :request do
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

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:expense) do
        Expense.create(name: 'pizza', amount: 5.2, user_id: user.id)
      end
    end
  end
end
