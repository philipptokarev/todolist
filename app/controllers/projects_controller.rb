class ProjectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  expose :projects, -> { Project.all }
  expose :project

  def index
    @task = Task.new
  end

  def create
    @project = current_user.projects.new(project_params)
    @task = Task.new

    respond_to do |format|
      if @project.save
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if project.update(project_params)
        @project = Project.new
        format.js
      end
    end
  end

  def destroy
    project.delete
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
