class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_categories_array, only: %i[edit update new create]

  # GET /expense or /expense.json
  def index
    @expense = Expense.order(created_at: :asc)
  end

  # GET /expense/1 or /expense/1.json
  def show
  end

  # GET /expense/new
  def new
    @expense = Category.where(author_id: current_user.id)
    @expense = Expense.new
  end

  # GET /expense/1/edit
  def edit
  end

  # POST /expense or /expense.json
  def create
    @category = Category.find_by(id: params[:category_id])
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    if @expense.save
      expense_category = ExpenseCategory.new(category_id: params[:category_id], expense_id: @expense.id)
      expense_category.save
      redirect_to expense_path(@expense)
      flash[:notice] = 'Expense added'
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        flash[:notice] = 'Expense not added'
      end
    end
  end

  # PATCH/PUT /expense/1 or /expense/1.json
  def update
    @expense = Expense.find_by(id: params[:id])

    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_path(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense/1 or /expense/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def expense_params
      params.require(:expense).permit(:name, :amount, :user_id)
    end

    def set_categories_array
      @category_array = Category.where(user_id: current_user.id)
    end
  
    def create_expense_category(category_ids, expense)
      category_ids.each do |category_id|
        ExpenseCategory.create(category_id: category_id, expense_id: expense.id)
      end
    end
end
