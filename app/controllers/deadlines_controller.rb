class DeadlinesController < ApplicationController
  def create
    @deadline = Deadline.create(deadline_params)
    @task_id = params[:deadline][:task_id]
  end
  def update
    @deadline = Deadline.find(params[:id])
    @deadline.update_attributes(deadline_params)
    respond_with_bip(@deadline)
  end

  def destroy
    @deadline = Deadline.find(params[:id])
    @task_id = params[:task_id]
    @deadline.destroy
  end

  private
    def deadline_params
      params.require(:deadline).permit(:deadline_formatted, :task_id )
    end

end