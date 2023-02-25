class Category < ApplicationRecord
    belongs_to :user

    has_many :expense_categories
    has_many :expenses, through: :expense_categories
    
    validates :name, presence: true
    validates :icon, presence: true
end
