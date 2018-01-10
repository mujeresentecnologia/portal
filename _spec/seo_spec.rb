require 'rspec'

describe 'SEO Metadatos' do
  context 'when title and description are defined on _config' do
    let(:doc) { load_home }
    let(:config) { load_main_config }

    it 'define a tag <title> inside <head>' do
      title_content = config.fetch('title')
      title_tag = doc.xpath('//title')

      expect(title_tag.text).to eql(title_content)
    end

    it 'define a tag <meta description> inside <head>' do
      desc_content = config.fetch('description')
      desc_tag = doc.xpath('//html/head/meta[@name="description"]')

      expect(desc_tag[0]['content']).to eql(desc_content)
    end
  end
end