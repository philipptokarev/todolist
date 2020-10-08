require "rails_helper"

feature "User get main page with projects and tasks" do
  let(:user) { create(:user) }

  scenario "Project \"Home\"" do
    login_as(user)
    create(:project, name: "Home", user: user)
    visit root_path
    expect(page).to have_content("Home")
  end

  scenario "Project \"Home\" with tasks" do
    login_as(user)
    projects = create(:project, name: "Home", user: user)
    tasks = create_list(:task, 6, project: projects)
    visit root_path
    expect(page).to have_content("Home")
    tasks.each do |task|
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.deadline.strftime("%d.%m.%Y %H:%M"))
    end
  end

  scenario "Projects with tasks" do
    login_as(user)
    projects = create_list(:project, 3, name: "Home", user: user)
    projects.each{ |project| create_list(:task, 6, project: project) }
    visit root_path
    projects.each do |project|
      expect(page).to have_content(project.name)
      project.tasks.each do |task|
        expect(page).to have_content(task.name)
        expect(page).to have_content(task.deadline.strftime("%d.%m.%Y %H:%M"))
      end
    end
  end
end
