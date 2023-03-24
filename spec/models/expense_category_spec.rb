require 'rails_helper'

RSpec.describe ExpenseCategory, type: :model do
  before :each do
    @user = User.create(name: 'Recilah', email: 'recillah@gmail.com', password: '123456',
                        password_confirmation: '123456')
    @category = Category.create(name: 'Books', icon: 'books.png', user_id: @user.id)
    @expense = Expense.create(name: 'tranz', amount: 20.7, user_id: @user.id)
    @expense_category = ExpenseCategory.new(category_id: @category.id, expense_id: @expense.id)
  end
  context 'Validations:' do
    it 'fails with nil category ' do
      @expense_category.category = nil
      @expense_category.save
      expect(@expense_category).to_not be_valid
    end
    it 'fails with nil transaction' do
      @expense_category.expense = nil
      @expense_category.save
      expect(@expense_category).to_not be_valid
    end
  end
end
