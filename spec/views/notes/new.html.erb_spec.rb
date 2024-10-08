require 'rails_helper'

RSpec.describe "notes/new", type: :view do
  before(:each) do
    assign(:note, build(:note))
  end

  it "renders new note form" do
    render

    assert_select "form[action=?][method=?]", notes_path, "post" do
      assert_select "input[name=?]", "note[title]"

      assert_select "textarea[name=?]", "note[body]"

      assert_select "select[name=?]", "note[project_id]"
    end
  end
end
