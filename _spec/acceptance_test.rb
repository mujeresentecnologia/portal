# Work in progress:
# For now, this test file it isn't being executed since its name doen not follow the pattern *_spec.rb
# 
# The idea of the test is to check that the urls generated from the .md files are accesible with a 200 code
# 
# to fix: even though files is getting this list as result ["./publicaciones.md", "./INSTALL.md", "./README.md", "./index.md", "./about.md"]
# the test never fails, and the result for visit INSTALL and README is 404. Needs to investigate why it never fails

require 'capybara_helper'
require 'yaml'

describe "URLs", :type => :feature do
  it "should create pages for each md file" do
    files = Dir["./*.md"]
    files.each do |file|
      filename = File.basename(file, ".md")
      visit "/" + filename + ".html"
      expect(page.status_code).to eq(200)
    end
  end

  it "should create pages for each post file" do
    files = Dir["_posts/*.md"]
    files.each do |file|
      filename = File.basename(file, ".md")
      visit "/" + filename + ".html"
      expect(page.status_code).to eq(200)
    end
  end
end