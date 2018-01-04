require 'rspec'

describe 'Site' do
  context 'cuando acceder al sitio' do
    let(:home) { load_home }
    let(:url) { load_main_config['url'] }

    it 'debe mostrar mensaje de aviso solo para staging' do
      element_list = home.xpath(%Q{//nav/div[@id="navbarWarning"]})
      if ENV['ENTORNO'] == "staging-env"; then
        expect(element_list.size).to eq(1)

        element_link = element_list[0].xpath('a')[0]
        expect(element_link.text).to eq("Usted está accediendo el ambiente de pruebas, para acceder el portal Mujeres en Tecnología, haga click aquí")
        expect(element_link.attr('href')).to eq(url)
      else
        expect(element_list.size).to eq(0)
      end
    end
  end
end