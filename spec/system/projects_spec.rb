# spec/system/projects_spec.rb
require 'rails_helper'

RSpec.describe "Projects", type: :system do
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }

  before do
    sign_in user
  end

  describe "CRUD actions" do
    it "allows creating a new project" do
      visit new_project_path

      fill_in 'Title', with: 'New Project'
      fill_in 'Description', with: 'Project description'
      click_button 'Create Project'

      expect(page).to have_content('Project was successfully created')
      expect(page).to have_content('New Project')
      expect(page).to have_content('Project description')
    end

    it "displays a list of projects" do
      visit projects_path

      expect(page).to have_content(project.title)
      expect(page).to have_content(project.description)
    end

    it "allows editing a project" do
      visit edit_project_path(project)

      fill_in 'Title', with: 'Updated Project'
      fill_in 'Description', with: 'Updated description'
      click_button 'Update Project'

      expect(page).to have_content('Project was successfully updated')
      expect(page).to have_content('Updated Project')
      expect(page).to have_content('Updated description')
    end

    it "allows deleting a project" do
      visit project_path(project)

      expect(page).to have_content(project.title)

      click_button 'Destroy this project'
      expect(page).to have_content('Project was successfully destroyed')
      expect(page).not_to have_content(project.title)
    end

    it "not allows deleting a immortal project" do
      project.update(immortal: true)
      visit project_path(project)

      expect(page).to have_content(project.title)

      click_button 'Destroy this project'
      expect(page).to have_content("Immortal can't be destroyed")
      expect(page).to have_content(project.title)
    end
  end
end
