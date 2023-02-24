class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trnsaction, only: %i[show edit update destroy]
  before_action :set_categories_array, only: %i[edit update new create]

  # GET /transactions or /transactions.json
  def index
    @transaction = Transaction.order(created_at: asc)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Category.where(author_id: current_user.id)
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    name = params['activity']['name']
    amount = params['activity']['amount']
    category_ids = params['activity']['categories']

    @transaction = Transaction.new(name: name, amount: amount)
    @transaction.user_id = current_user.id

    respond_to do |format|
      if @transaction.save
        create_transaction_category(category_ids, @transaction)
        format.html do
          redirect_to category_url(category_ids[0]), notice: "Activity#{category_ids.length > 1 ? 's were' : was } successfully created." 
        end
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def transaction_params
      params.require(:transaction).permit(:name, :amount, :categories)
    end

    def set_categories_array
      @category_array = Category.where(author_id: current_user.id)
    end
  
    def create_transaction_category(category_ids, transaction)
      category_ids.each do |category_id|
        TransactionCategory.create(category_id: category_id, transaction_id: transaction.id)
      end
    end
end
