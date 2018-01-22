require 'rspec'

describe 'All posts' do
  
  context 'Drafts' do
    let(:drafts_files) { load_all_drafts }
    let(:posts_page) { load_page('publicaciones')}

    it 'page for all publications should show drafts for staging environment' do
      if ENV['ENTORNO'] == "staging-env"; then
        expect(drafts_files).to all(
          satisfy do |draft|
            post_title = File.basename(draft, ".md")
            post_data = load_markdown("_drafts/#{post_title}")

            links_on_page = posts_page.xpath(%Q{//ul//li//a[@href="/#{post_title}"]})

            expect(links_on_page.size).to eq(2)
            expect(links_on_page[0].text).to eq(post_data["title"].upcase)
            expect(links_on_page[1].text).to eq("Ver más")
          end)
      end
    end

    it 'page for all publications should not show drafts for prod environment' do
      if ENV['ENTORNO'] != "staging-env"; then
        expect(drafts_files).to all(
          satisfy do |draft|
            post_title = File.basename(draft, ".md")
            links_on_page = posts_page.xpath(%Q{//ul//li//a[@href="/#{post_title}"]})

            expect(links_on_page.size).to eq(0)
          end)
      end
    end
  end
end