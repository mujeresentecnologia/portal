require 'rspec'

describe 'All posts' do
  context 'Published by' do
    let(:organizaciones) { load_data('organizaciones') }
    let(:drafts_files) { load_all_drafts }
    let(:posts_files) { load_all_posts }
    let(:publication_page) { load_page("published") }
    let(:toggles) { load_data("toggles") }

    it 'all posts should be published by one existing organization' do
      expect(posts_files).to all(
        satisfy do |post|
          post_title = File.basename(post, ".md")
          post_data = load_markdown("_posts/#{post_title}")

          expect(post_data["organization_id"]).to be
          expect(organizaciones[post_data["organization_id"]]).to be
        end)
    end

    it 'If there is more than 6 publications, I can see only 6 posts and a button' do
      if toggles["published"]["show_more_posts"] ; then
        max_posts = 6
        not_empty = 1
        posts_content = publication_page.css('.met_content met_hidden')
        show_more_button = publication_page.css('.met_button')

        if posts_content.size > max_posts ; then
          expect(posts_content.size).to eq(max_posts)
          expect(show_more_button.size).to eq(not_empty)
        end
      end
    end

    it 'Less than 6 publications, I can see them and button disappears' do
      if toggles["published"]["show_more_posts"] ; then
        max_posts = 6
        empty = 0
        posts_content = publication_page.css('.met_content').xpath(".//li[not (@hidden)]")
        show_more_button = publication_page.css('.met_button')

        if posts_content.size < max_posts ; then
          expected_size = posts_content.size % max_posts
          expect(posts_content.size).to eq(expected_size)
          expect(show_more_button.size).to eq(empty)
        end
      end
    end
  end
  
  context 'Drafts' do
    let(:drafts_files) { load_all_drafts }
    let(:posts_page) { load_page('published')}
    let(:organizaciones) { load_data('organizaciones') }

    it 'all drafts should be published by one existing organization' do
      expect(drafts_files).to all(
        satisfy do |draft|
          post_title = File.basename(draft, ".md")
          post_data = load_markdown("_drafts/#{post_title}")

          expect(post_data["organization_id"]).to be
          expect(organizaciones[post_data["organization_id"]]).to be
        end)
    end

    it 'page for all publications should show drafts for staging environment' do
      if ENV['ENTORNO'] == "staging-env"; then
        expect(drafts_files).to all(
          satisfy do |draft|
            post_title = File.basename(draft, ".md")
            post_data = load_markdown("_drafts/#{post_title}")

            links_on_page = posts_page.xpath(%Q{//ul//li//a[@href="#{post_title}"]})

            post_item = posts_page.xpath("//li[contains(@id,\'#{post_data['title']}\')]")
            link_organization = post_item.at('.met_post_author').at('a')

            expect(links_on_page.size).to eq(2)
            expect(links_on_page[0].text).to eq(post_data["title"].upcase)
            expect(links_on_page[1].text).to eq("Ver más")

            org = organizaciones[post_data["organization_id"]]

            expect(link_organization.text).to eq(org["name"])
            expect(link_organization.attribute('href').text).to eq(org["url"])
          end)
      end
    end

    it 'page for all publications should not show drafts for prod environment' do
      if ENV['ENTORNO'] != "staging-env"; then
        expect(drafts_files).to all(
          satisfy do |draft|
            post_title = File.basename(draft, ".md")
            links_on_page = posts_page.xpath(%Q{//ul//li//a[@href="#{post_title}"]})

            expect(links_on_page.size).to eq(0)
          end)
      end
    end
  end
end