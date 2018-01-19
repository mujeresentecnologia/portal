require 'rspec'
require_relative '../_utils/organizations.rb'

describe 'Organizations' do
  context 'When the organizations are defined in _data/organizaciones.yml' do
    let(:organizaciones) { load_data('organizaciones') }
    let(:org_logos) { organizaciones.map {
                                          |org|
                                          attributes = org[1]
                                          attributes['logo']} }

    context 'And I am looking at the file' do
      it 'Logos should exist' do
        expect(org_logos).to all(
          satisfy do |logo|
            path = File.join('./assets/images/', logo)
            File.file?(path)
          end)
      end
    end

    context 'When I am in the Home Page' do
      let(:home) { load_home }
      let(:organizaciones) { load_data('organizaciones') }
      let(:grid_styles) {load_data('structure/grid_styles')}

      it "I should see all the logos from the organizations" do
        organizaciones.each do |org|
          attributes = org[1]
          element_src = home.css('.met_logos').xpath(%Q{//img[@src="assets/images/#{attributes['logo']}"]})
          element_alt = home.css('.met_logos').xpath(%Q{//img[@alt="#{attributes['name']}"]})

          expect(element_src.size).to eq(1)
          expect(element_alt.size).to eq(1)
        end
      end

      it "I should see the logos in the right position, defined in the file" do
        organizaciones.each do |org|
          attributes = org[1]
          element_src = home.css('.met_logos').xpath(%Q{//img[@src="assets/images/#{attributes['logo']}"]})
          element_class = element_src[0].parent.attr('class')

          expect(element_class).to eq(grid_styles["#{attributes['position']}"][0]['style'])
        end
      end
    end

    context "When I am in About Page" do
      let(:about) { load_page("about") }
      let(:organizaciones) { load_data("organizaciones") }

      it "I should see description of organization if it has content" do
        counter = 0
        organizaciones.each do |org|
          attributes = org[1]

          if attributes["content"]

            name = attributes["name"]
            h3_search_pattern = "div#met_org_" + counter.to_s + " h3"
            h3_element = about.css(h3_search_pattern)
            element_text = h3_element.text

            expect(element_text).to match(name.upcase)
            counter += 1
          end
        end
      end
    end
  end
end