require 'rspec'
require 'capybara_helper'
require 'yaml'

describe "Drafts", :type => :feature do
  let(:drafts_files) { load_all_drafts }
  let(:organizations) { load_data("organizaciones") }
  it "drafts should only be generated for staging environment" do
    if ENV['ENTORNO'] == "staging-env"; then
		  expect(drafts_files).to all(
        satisfy do |file|

          post_title = File.basename(file, ".md")
          post_data = load_markdown("_drafts/#{post_title}")
          post_page = load_page(post_title)

          expect(post_page.xpath('//h1').text).to eq(post_data["title"])
        end)
	  end
  end

  it "drafts should not be generated for production environment" do
    if ENV['ENTORNO'] != "staging-env"; then
		  expect(drafts_files).to all(
			  satisfy do |file|

		    post_title = File.basename(file, ".md")
	      expect(File).not_to exist("_site/#{post_title}.html")
	    end)
    end
  end

  it "url of drafts should be like file name" do
    if ENV['ENTORNO'] != "staging-env"; then
		  expect(drafts_files).to all(
			  satisfy do |file|
        
        file_name = File.basename(file, ".md")
        visit "/" + file_name + ".html"
        expect(page.status_code).to eq(200)
      end)
    end
  end

  it "all posts are generated with the correct logo from the organization" do
    if ENV['ENTORNO'] == "staging-env"; then
      expect(drafts_files).to all(
		  satisfy do |file|

        post_title = File.basename(file, ".md")
        post_data = load_markdown("_drafts/#{post_title}")
        post_page = load_page(post_title)
        id = post_data["organization_id"]
        expected_img_alt = organizations[id]['name']

        image_tag = post_page.css("img[alt='#{organizations[id]['name']}']")
        img_alt_from_post = image_tag[0].attributes["alt"].text

        expect(img_alt_from_post).to match(expected_img_alt)
      end)
    end
  end
end

describe "Posts" do
  it "all posts are generated with correct title" do
    if ENV['ENTORNO'] != "staging-env"; then
      posts_files = load_all_posts

	  expect(posts_files).to all(
		  satisfy do |file|

        post_title = File.basename(file, ".md")
        post_data = load_markdown("_posts/#{post_title}")
        post_page = load_page(post_title)

        expect(post_page.xpath('//h1').text).to eq(post_data["title"])
      end)
    end
  end
end