class TodosController < ApplicationController
  def index
    todos = Todo.order(:created_at)
    render json: todos
  end
end
