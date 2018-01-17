require 'rspec'

describe 'Content in About Page' do
  context 'When I see the about page' do
    let(:about) { load_page("about") }
    let(:markdown) { load_markdown("about") }

    it "I can read the first paragraph of MET's description" do
      paragraphs = about.css('.met_dark').xpath(%Q{//p})

      first_paragraph = paragraphs[0]
      expect(markdown["first_paragraph"]).to match(first_paragraph)

    end
  end
end