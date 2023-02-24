require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    @user = User.create(name: 'Recilah', email: 'recillah@gmail.com', password: '123456', password_confirmation: '123456')
  end

  describe 'User ' do
    it 'is not valid with invalid attributes' do
      expect(User.new).to_not be_valid
    end

    it 'is valid with valid attributes' do
      subject.save
      expect(subject).to be_valid
    end

    it 'is valid when name is changed' do
      subject.name = 'Neema'
      expect(subject).to be_valid
    end
  end
end

