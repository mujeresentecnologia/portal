require 'rspec'

describe 'Organizaciones' do
  context 'cuando organizaciones estan definidas en el archivo _data/organizaciones.yml' do
    let(:organizaciones) { load_data('organizaciones') }
    let(:org_logos) { organizaciones.map {|org| org['logo']} }

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
          element_src = home.css('.met_logos').xpath(%Q{//img[@src="assets/images/#{org['logo']}"]})
          element_alt = home.css('.met_logos').xpath(%Q{//img[@alt="#{org['name']}"]})

          expect(element_src.size).to eq(1)
          expect(element_alt.size).to eq(1)
        end
      end

      it "los logos deben estar ordenados de acuerdo con la posicion determinada en el archivo" do
        organizaciones.each do |org|
          element_src = home.css('.met_logos').xpath(%Q{//img[@src="assets/images/#{org['logo']}"]})
          element_class = element_src[0].parent.attr('class')

          expect(element_class).to eq(grid_styles["#{org['position']}"][0]['style'])
        end
      end
    end

    context "Cuando estoy en la página quienes somos" do
      let(:about) { load_page("about") }
      let(:organizaciones) { load_data("organizaciones") }

      it "Puedo ver el título de cada institucion que tiene contenido" do        
        organizaciones.each do |org|
          if org["content"]
            name = org["name"]
            h3_search_pattern = "div#met_org_" + org['id'].to_s + " h3"
            h3_element = about.css(h3_search_pattern)
            element_text = h3_element[0].text
            expect(element_text).to match(name.upcase)
          else
            empty_element = 0
            div_search_pattern = "div#met_org_" + org['id'].to_s
            div_element = about.css(div_search_pattern)
            expect(div_element.size).to eq(empty_element)
          end
        end
      end 

      it "Puedo ver la descripción de cada institucion" do
        organizaciones.each do |org|
          if org["content"]
            content = org["content"]
            p_search_pattern = "div#met_org_" + org['id'].to_s + " p"
            paragraph = about.css(p_search_pattern)
  
            expected_text = paragraph[0].text
            expect(expected_text).to match(content)
          else 
            empty_element = 0
            div_search_pattern = "div#met_org_" + org['id'].to_s
            description = about.css(div_search_pattern)

            expect(description.size).to eq(empty_element)
          end
        end
      end 

      it "Deberia mostrar url de la institucion en caso de contener uno" do
        organizaciones.each do |org|
          content_url = org["url"]
          a_search_pattern = "div#met_org_" + org['id'].to_s + " a"
          url = about.css(a_search_pattern)
          empty = 0;
          index = 0;
          if content_url == nil
            expect(url.size).to equal(empty)
          else
            expected_url = url[index]["href"]
            expect(expected_url).to match(content_url)
          end
        end
      end

      it "Deberia mostrar logo de la institución de cada organización" do
        organizaciones.each do |org|
          if org["content"]
            logo = org["logo"]
            name = org["name"]
            image_search_pattern = "div#met_org_" + org['id'].to_s + " img"
            images = about.css(image_search_pattern)
            image_src = images[0]["src"]
            image_alt = images[0]["alt"]
            expected_src_value = "assets/images/" + logo
            
            expect(image_src).to match(expected_src_value)
            expect(image_alt).to match(name)
          else
            empty_element = 0
            div_search_pattern = "div#met_org_" + org['id'].to_s
            images = about.css(div_search_pattern)

            expect(images.size).to eq(empty_element)
          end
        end
      end
    end
  end
end