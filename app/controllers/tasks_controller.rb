class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token

  expose :task
  expose :project

  def new
    @task = Task.new
  end

  def create
    @task = project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if task.update(task_params)
        @task = Task.new
        format.js
      end
    end
  end

  def destroy
    task.delete
  end

  def toggle
    task = Task.find(params[:id])
    unless task.update(status: params[:status])
      redirect_to user_project_path(id: project.id), notice: "Task not updated"
    end
  end

  def sort
    params[:task].each_with_index do |id, index|
      Task.find(id).update(position: index+1)
    end
  end

  private

  def task_params
    params.require(:task).permit(:status, :name)
  end
end
