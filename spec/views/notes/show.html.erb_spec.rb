require 'rails_helper'

RSpec.describe "notes/show", type: :view do
  before(:each) do
    assign(:note, create(:note, title: "My Title", body: "My body text"))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/My Title/)
    expect(rendered).to match(/My body text/)
  end
end
