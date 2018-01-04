require 'rspec'

describe 'Site' do
  context 'cuando acceder al sitio' do
    let(:home) { load_home }
    it 'debe mostrar mensaje de aviso solo para staging' do
      element_list = home.xpath(%Q{//nav/div[@id="navbarWarning"]})

      if ENV['ENTORNO'] == "staging-env"; then
        expect(element_list.size).to eq(1)
        expect(element_list.text).to match("Usted está accediendo el ambiente de pruebas, para acceder el portal Mujeres en Tecnología, haga click aquí")
      else
        expect(element_list.size).to eq(0)
      end
    end
  end
end