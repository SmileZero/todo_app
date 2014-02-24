class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /todos
  def index
    if params[:user_id]
      @todos = Todo.where(user_id: params[:user_id]).page(params[:page]).per(3)
    else
      @todos = Todo.all.page(params[:page]).per(3)
    end
  end

  # GET /todos/1
  def show
    if request.xhr?
      render partial: 'show_body'
    end
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
    if request.xhr?
      render partial: 'form'
    end
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to @todo, notice: 'Todo was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      if @remote
        respond_to do |format|
            format.js
        end
      else
        redirect_to @todo, notice: 'Todo was successfully updated.'
      end
    else
      render action: 'edit'
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    redirect_to todos_url, notice: 'Todo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todo_params
      params.require(:todo).permit(:due, :task, :memo, :user_id)
    end

    def require_login
      redirect_to(root_url, notice: 'Please Log In.') unless session[:login]
    end
end
