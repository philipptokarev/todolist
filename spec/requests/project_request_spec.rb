require 'rails_helper'

RSpec.describe "Projects and tasks controllers", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  before do
    login_as(user)
  end

  describe "projects and tasks actions" do
    it "GET projects#index" do
      get '/'
      expect(response.body).to include "simple todo list"
      expect(response).to have_http_status(:success)
    end

    it "POST users/:user_id/projects#create" do
      post "/users/#{user.id}/projects", params: { project: { name: "Home" }, format: :js }
      expect(response).to have_http_status(:success)
      get '/'
      expect(response.body).to include("Home")
    end

    it "POST users/:user_id/projects/:project_id/tasks#create" do
      post "/users/#{user.id}/projects/#{project.id}/tasks", params: { task: { name: "Project task", deadline: Date.today }, format: :js }
      expect(response).to have_http_status(:success)
      get '/'
      expect(response.body).to include(project.name)
      expect(response.body).to include("Project task")
      expect(response.body).to include(Date.today.strftime("%d.%m.%Y %H:%M"))
    end

    it "PATCH users/:user_id/projects#update" do
      project = create(:project, name: "Home", user: user)
      get '/'
      expect(response.body).to include("Home")
      patch "/users/#{user.id}/projects/#{project.id}", params: { project: { name: "Work" }, format: :js }
      expect(response).to have_http_status(:success)
      get '/'
      expect(response.body).to include("Work")
    end

    it "PATCH users/:user_id/projects/:project_id/tasks#update" do
      task = create(:task, name: "New task", deadline: Date.today, project: project)
      get '/'
      expect(response.body).to include(project.name)
      expect(response.body).to include("New task")
      expect(response.body).to include(Date.today.strftime("%d.%m.%Y %H:%M"))
      patch "/users/#{user.id}/projects/#{project.id}/tasks/#{task.id}", params: { task: { name: "Work task", deadline: Date.today + 2.days }, format: :js }
      expect(response).to have_http_status(:success)
      get '/'
      expect(response.body).to include(project.name)
      expect(response.body).to include("Work task")
      expect(response.body).to include((Date.today + 2.days).strftime("%d.%m.%Y %H:%M"))
    end

    it "DELETE users/:user_id/projects#delete" do
      delete "/users/#{user.id}/projects/#{project.id}", params: { format: :js }
      expect(response).to have_http_status(:success)
      get '/'
      expect(response.body).to_not include("Home")
    end

    it "DELETE users/:user_id/projects/:project_id/tasks#delete" do
      delete "/users/#{user.id}/projects/#{project.id}/tasks/#{task.id}", params: { format: :js }
      expect(response).to have_http_status(:success)
      get '/'
      expect(response.body).to_not include("Project task")
      expect(response.body).to_not include(Date.today.strftime("%d.%m.%Y %H:%M"))
    end
  end
end
