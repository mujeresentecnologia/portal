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
  end
end