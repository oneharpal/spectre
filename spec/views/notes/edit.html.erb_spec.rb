require 'rails_helper'

RSpec.describe "notes/edit", type: :view do
  let(:note) { create(:note)  }

  before(:each) do
    assign(:note, note)
  end

  it "renders the edit note form" do
    render

    assert_select "form[action=?][method=?]", note_path(note), "post" do

      assert_select "input[name=?]", "note[title]"

      assert_select "textarea[name=?]", "note[body]"

      assert_select "select[name=?]", "note[project_id]"
    end
  end
end
0