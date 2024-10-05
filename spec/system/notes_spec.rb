require 'rails_helper'

RSpec.describe "Notes", type: :system do
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }
  let!(:note) { create(:note, project: project) }

  before do
    sign_in user # Ensure the user is signed in
  end

  describe "Creating a note" do
    it "allows the user to create a note with a project" do
      visit new_note_path

      fill_in 'Title', with: 'New Note Title'
      fill_in 'Body', with: 'This is the body of the new note'
      select project.title, from: 'Project' if page.has_select?('Project') # Associate the note with a project by title
      click_button 'Create Note'

      expect(page).to have_content('Note was successfully created')
      expect(page).to have_content('New Note Title')
      expect(page).to have_content('This is the body of the new note')
    end
  end

  describe "Viewing a note" do
    it "shows the details of a note" do
      visit note_path(note)

      expect(page).to have_content(note.title)
      expect(page).to have_content(note.body)
      expect(page).to have_content(project.title)
    end
  end

  describe "Editing a note" do
    it "allows the user to edit a note" do
      visit edit_note_path(note)

      fill_in 'Title', with: 'Updated Note Title'
      fill_in 'Body', with: 'Updated note body'
      click_button 'Update Note'

      expect(page).to have_content('Note was successfully updated')
      expect(page).to have_content('Updated Note Title')
      expect(page).to have_content('Updated note body')
    end
  end

  describe "Deleting a note" do
    it "allows the user to delete a note" do
      visit note_path(note)

      expect(page).to have_content(note.title)

      click_button 'Destroy' # Change to clicking the destroy button

      expect(page).to have_content('Note was successfully destroyed')
      expect(page).not_to have_content(note.title)
    end
  end
end
