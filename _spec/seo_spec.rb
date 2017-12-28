require 'rspec'

describe 'SEO Metadatos' do
  context 'when title and description are defined on _config' do
    let(:doc) { load_home }
    let(:title_content) { load_main_config().fetch('title') }

    it 'define a tag <title> inside <head>' do
      # byebug
      title_tag = doc.xpath('//title')

      expect(title_tag.text).to eql(title_content)
    end
  end
end