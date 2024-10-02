require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, create_list(:note, 2, title: "Note Title", body: "Note Body"))
  end

  it "renders a list of notes" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Note Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Note Body".to_s), count: 2
  end
end
