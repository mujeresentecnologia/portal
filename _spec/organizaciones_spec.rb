require 'rspec'
require_relative '../_utils/organizations.rb'

describe 'Organizaciones' do
  context 'cuando organizaciones estan definidas en el archivo _data/organizaciones.yml' do
    let(:organizaciones) { load_data('organizaciones') }
    let(:org_logos) { organizaciones.map {
                                          |org|
                                          attributes = org[1]
                                          attributes['logo']} }

    context 'cuando mirando el archivo' do
      it 'imagenes de logo deben existir' do
        expect(org_logos).to all(
          satisfy do |logo|
            path = File.join('./assets/images/', logo)
            File.file?(path)
          end)
      end
    end

    context 'cuando mirando la pagina inicial' do
      let(:home) { load_home }
      let(:organizaciones) { load_data('organizaciones') }
      let(:grid_styles) {load_data('structure/grid_styles')}

      it "los logos de todas las organizaciones deben estar en la pagina inicial" do
        organizaciones.each do |org|
          attributes = org[1]
          element_src = home.css('.met_logos').xpath(%Q{//img[@src="assets/images/#{attributes['logo']}"]})
          element_alt = home.css('.met_logos').xpath(%Q{//img[@alt="#{attributes['name']}"]})

          expect(element_src.size).to eq(1)
          expect(element_alt.size).to eq(1)
        end
      end

      it "los logos deben estar ordenados de acuerdo con la posicion determinada en el archivo" do
        organizaciones.each do |org|
          attributes = org[1]
          element_src = home.css('.met_logos').xpath(%Q{//img[@src="assets/images/#{attributes['logo']}"]})
          element_class = element_src[0].parent.attr('class')

          expect(element_class).to eq(grid_styles["#{attributes['position']}"][0]['style'])
        end
      end
    end

    context "Cuando estoy en la página quienes somos" do
      let(:about) { load_page("about") }
      let(:organizaciones) { load_data("organizaciones") }

      it "Should see description of organization if it has content" do
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