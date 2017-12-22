require 'rspec'

describe 'Google Analytics' do
  context 'when the Google Analytics ID is defined on _config' do
    let(:doc) { load_home }
    let(:google_id) { load_config().fetch('google_analytics') }

    it 'define a tag <script> inside <head>' do
      elements = doc.xpath(%Q{/html/head/script[contains(., "#{google_id}")]})

      expect(elements.size).to eq(1)
    end
  end
end