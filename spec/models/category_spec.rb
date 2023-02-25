require 'rails_helper'

RSpec.describe Category, type: :model do
  before :each do
    @user = User.create(name: 'Recilah', email: 'recillah@gmail.com', password: '123456',
                        password_confirmation: '123456')
    @category = Category.new(name: 'Books', icon: 'books.png')
    @category.user = @user
  end
  context 'Validations:' do
    it 'Category with valid data' do
      @category.save
      expect(@category).to be_valid
    end
    it 'Category with name empty ' do
      @category.name = ''
      @category.save
      expect(@category).to_not be_valid
    end
    it 'Category with icon empty' do
      @category.icon = nil
      @category.save
      expect(@category).to_not be_valid
    end
  end
end
