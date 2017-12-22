require 'rspec'

describe 'Google Analytics' do
  context 'when the Google Analytics ID is defined on _config' do
    let(:doc) { load_home }

    if ENV['ENTORNO'] == "staging-env"; then
      let(:google_id) { load_config('staging').fetch('google_analytics') }
    else
      let(:google_id) { load_config('prod').fetch('google_analytics') }
    end

    it 'define a tag <script> inside <head>' do
      elements = doc.xpath(%Q{/html/head/script[contains(., "#{google_id}")]})

      expect(elements.size).to eq(1)
    end
  end
end