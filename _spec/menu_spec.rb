require 'rspec'

describe 'Menu' do
  context 'cuando los links del menu estan definidos en el archivo _data/menu.yml' do
    let(:menu_links) { load_data('menu') }
    let(:home) { load_home }

    context 'cuando mirando la pagina inicial' do
      it 'todos los links deben estar en el navbar' do
        expect(menu_links).to all(
          satisfy do |item|

            element_list = home.css('.nav').xpath(%Q{//ul/li})
            element_link = element_list.xpath(%Q{a[@href="#{item['link']}"]})

            expect(element_list.attr('class').value).to eq("met_navbar_color_#{item['color']}")
            expect(element_link.size).to eq(1)
            expect(element_link.text).to eq(item['nombre'])
          end)
      end
    end
  end
end