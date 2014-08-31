class TasksController < ApplicationController
  before_action :task_owner, except: :create
  before_action :list_owner, only: :create

  def create
    @task = Task.new(task_params)
    if @task.save
      @date = Date.parse(params[:task][:deadline]) rescue nil
      if @date
        @task.create_deadline(deadline: @date)
      end
    end
  end
  def update
    @task.update_attributes(task_params)
    respond_with_bip(@task)
  end
  def destroy
    @task.destroy
  end

  def toggle
    @task.update_attributes(mark: params[:mark])
    render json: :ok
  end

  private
    def task_owner
      @task = Task.find(params[:id])
      @task_list = @task.task_list
      unless @task_list.user_id == current_user.id
        redirect_to current_user
        flash[:info] = 'Error'
      end
    end
    def list_owner
      @task_list = TaskList.find_by(id: params[:task][:task_list_id])
      unless @task_list.user_id == current_user.id
        redirect_to current_user
        flash[:info] = 'Error'
      end
    end
    def task_params
      params.require(:task).permit(:task_list_id, :content)
    end
end

