class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

#   Associations
has_many :expenses
has_many :categories

# Validations
validates :name, presence: true
validates :email, presence: true
end
