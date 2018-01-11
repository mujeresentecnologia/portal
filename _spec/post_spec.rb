require 'test_helper'
require 'yaml'

describe "Posts", :type => :feature do
  it "Cuando visito las publicaciones verifico si sus URL son validas" do
    drafts_files = Dir["_drafts/*.md"]
    
    drafts_files.each{
      |file|
      post_title = File.basename(file, ".md")
      visit "/" + post_title + ".html"
      expect(page.status_code).to eq(200)
    }
  end
end