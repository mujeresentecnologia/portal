require 'rspec'

describe 'Contenido estático' do
  context 'Cuando despliego la página about' do
    let(:about) { load_page("about") }
    let(:static_content) { load_data("static_content") }
    it 'debiera existir la seccion description con título' do
      expected_value = "MUJERES EN TECNOLOGÍA"
      title = about.css('#description_title').text

      expect(title).to match(expected_value)
    end

    it 'deberia mostrar texto en párrafo izquierdo cuando se carga data de _data/static_content.yml' do
      expected_value = static_content["about"]["description"]["left"]
      left_paragraph = about.css("#left_paragraph").text 

      expect(left_paragraph).to match(expected_value)
    end

    it 'deberia mostar texto en párrafo derecho cuando se carga de _data/static_content.yml' do
      expected_value = static_content["about"]["description"]["right"]
      right_paragraph = about.css("#right_paragraph").text 

      expect(right_paragraph).to match(expected_value)
    end
  end
end