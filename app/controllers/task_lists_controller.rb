class TaskListsController < ApplicationController
  before_action :current_task_list, except: [:new, :create, :sort]
  respond_to :html, :json

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.user_id = current_user.id
    respond_to do |format|
      if @task_list.save
        format.html { redirect_to current_user }
      else
        format.html {
          @task_list.errors.full_messages.each do |msg|
            flash.now[:warning] = msg
          end
          render 'new'
        }
      end
      format.js
    end

  end

  def edit
  end

  def update
    respond_to do |format|
      if @task_list.update_attributes(task_list_params)
        format.json { respond_with_bip(@task_list) }
      else
        format.json { respond_with_bip(@task_list) }
      end
    end
  end

  def destroy
    @task_list.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end

  end

  def sort
    params[:task_li_id].each_with_index do |id, index|
      Task.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  private

    def task_list_params
      params.require(:task_list).permit(:header)
    end
    def current_task_list
      @task_list = TaskList.find(params[:id])
    end
end
