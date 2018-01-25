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

          expect(post_page.xpath('//h1').text).to eq(post_data["title"].upcase)
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
        expected_img_src = "assets/images/#{organizations[id]['logo']}"

        image_tag = post_page.css("img[alt='#{organizations[id]['name']}']")
        img_alt_from_post = image_tag[0].attributes["alt"].text
        img_src_from_post = image_tag[0].attributes["src"].text

        expect(img_alt_from_post).to match(expected_img_alt)
        expect(img_src_from_post).to match(expected_img_src)
      end)
    end
  end

  it "all post with links inside the content should open in other page" do
    if ENV['ENTORNO'] == "staging-env"; then
      expect(drafts_files).to all(
        satisfy do |file|

          post_title = File.basename(file, ".md")
          post_data = load_markdown("_drafts/#{post_title}")
          post_page = load_page(post_title)

          expected_status_code = 200
          expected_target_value = "_blank"

          tags = post_page.css(".met_post").css("a")

          tags.each{ |tag|
            target_from_post = tag.attributes["target"].text
            href_from_post = tag.attributes["href"].text
            visit href_from_post
            expect(target_from_post).to match(expected_target_value)
            expect(page.status_code).to eq(expected_status_code)
          }
        end)
    end
  end

  it "all post should redirect given an organization image " do
    if ENV['ENTORNO'] == "staging-env"; then
      expect(drafts_files).to all(
        satisfy do |file|

          post_title = File.basename(file, ".md")
          post_data = load_markdown("_drafts/#{post_title}")
          post_page = load_page(post_title)
          id = post_data["organization_id"]
          expected_url = organizations[id]['url']

          expected_status_code = 200
          expected_target_value = "_blank"

          tags = post_page.css(".met_post_publisher").css("a")
          last_tag = tags.last

          target_from_logo = last_tag.attributes["target"].text
          href_from_logo = last_tag.attributes["href"].text
          visit href_from_logo
          expect(href_from_logo).to match(expected_url)
          expect(target_from_logo).to match(expected_target_value)
          expect(page.status_code).to eq(expected_status_code)
        end)
    end
  end

  it "all post should render the publication date in traditional format" do
    if ENV['ENTORNO'] == "staging-env"; then
      months = load_data("months")
      expect(drafts_files).to all(
        satisfy do |file|
          post_title = File.basename(file, ".md")
          post_data = load_markdown("_drafts/#{post_title}")
          post_page = load_page(post_title)
          id = post_data["organization_id"]
          post_date = post_data["date"]
          expected_formatted_date = format_traditional_date(post_date, months).upcase
          page_date = post_page.css(".met_post_date").text

          expect(page_date).to match(expected_formatted_date)
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