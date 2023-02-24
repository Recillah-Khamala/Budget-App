class TransactionCategory < ApplicationRecord
  belongs_to :category
  belongs_to :transaction
end
