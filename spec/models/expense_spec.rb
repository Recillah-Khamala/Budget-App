require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'expense model' do
    before(:each) do
      @user = User.create(name: 'Recilah', email: 'recillah@gmail.com', password: '123456',
                          password_confirmation: '123456')
      @category = Category.new(name: 'Books', icon: 'books.png')
    end
    it 'does not accept an invalid name' do
      expense = Expense.create name: '', amount: 13, user_id: @user.id
      expect(expense).to_not be_valid
    end
    it 'does not accept an invalid amount' do
      expense = Expense.create name: 'Harry Porter', amount: '', user_id: @user.id
      expect(expense).to_not be_valid
    end
    it 'does not accept an invalid user_id' do
      expense = Expense.create name: 'Harry Porter', amount: 13, user_id: nil
      expect(expense).to_not be_valid
    end
    it 'does not accept an invalid name, amount and user_id' do
      expense = Expense.create name: '', amount: '', user_id: nil
      expect(expense).to_not be_valid
    end
  end
end
