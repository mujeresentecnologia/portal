require 'rspec'

describe 'Contenidos de Banners' do
  let(:banners) { load_data('banners') }

  context 'Cuando estoy en página de home' do
    let(:home) { load_page("index") }
    it 'debería existir una sección para banner home' do
      section = home.css('.met_banner_home')
      
      expect(section).not_to be_empty
    end

    it 'debería existir texto para banner home' do
      texto_banner = home.css('.met_banner_text').text
      expected_value = banners["home"][0]["text"]
      if expected_value.nil?
        expected_value = ""
      end
      
      expect(texto_banner).to match(expected_value)
    end
  end

  context 'Cuando estoy en página Quienes Somos' do
    let(:about) { load_page("about") }
    it 'debería existir una sección para banner about' do
      section = about.css('.met_banner_about')
      
      expect(section).not_to be_empty
    end

    it 'debería existir texto para banner about' do
      texto_banner = about.css('.met_banner_text').text
      expected_value = banners["about"][0]["text"]
      if expected_value.nil?
        expected_value = ""
      end
      expect(texto_banner).to match(expected_value)
    end
  end

  context 'when I see published page' do
    let(:published) { load_page("published") }
    it 'should exists a banner section' do
      section = published.css('.met_banner_published')
      
      expect(section).not_to be_empty
    end
  end
end