class TasksController < ApplicationController
  before_action :task_owner, except: :create
  before_action :list_owner, only: :create

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to current_user }
      else
        format.html {
          redirect_to current_user
          @task.errors.full_messages.each do |msg|
            flash[:warning] = msg
          end
        }
      end
      format.js
    end
  end
  def update
    respond_to do |format|
      if @task.update_attributes(task_params)
        format.json { respond_with_bip(@task) }
      else
        format.json { respond_with_bip(@task) }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end

  end

  def toggle
    @task.update_attributes(mark: params[:mark])
    render json: :ok
  end

  def priority_up
    @task.decrement_position
    redirect_to current_user
  end

  def priority_down
    @task.increment_position
    redirect_to current_user
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

