require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    assign(:transaction, Transaction.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
