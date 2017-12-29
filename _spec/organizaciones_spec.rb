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

      it "los logos de todas las organizaciones deben estar en la pagina inicial" do
        organizaciones.each do |org|
          element_src = home.css('.met_logos').xpath(%Q{//img[@src="assets/images/#{org['logo']}"]})
          element_alt = home.css('.met_logos').xpath(%Q{//img[@alt="#{org['nombre']}"]})

          expect(element_src.size).to eq(1)
          expect(element_alt.size).to eq(1)
        end
      end
    end
  end
end