require 'rspec'

describe 'Content in About Page' do
  context 'When I see the about page' do
    let(:about) { load_page("about") }
    let(:markdown) { load_markdown("about") }

    it "I can read the title of MET" do
      content = about.css('.met_dark').xpath(%Q{//h1})

      title = content[0]

      expect(title.text).to match(markdown["title"])

    end

    it "I can read the first paragraph of MET's description" do
      paragraphs = about.css('.met_dark').xpath(%Q{//p})

      first_paragraph = paragraphs[0]
      expect(first_paragraph.text).to match(markdown["first_paragraph"])

    end

    it "I can read the second paragraph of MET's description" do
      paragraphs = about.css('.met_dark').xpath(%Q{//p})

      second_paragraph = paragraphs[1]
      expect(second_paragraph.text).to match(markdown["second_paragraph"])
    end


  end
end