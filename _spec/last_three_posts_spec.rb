describe 'All posts' do
	context 'I am in Home Page' do
		let(:posts_files) { load_all_posts }
		let(:toggles) { load_data("toggles") }
		it 'and I can see the last three posts' do
			if ENV['ENTORNO'] != "staging-env" && toggles["home"]["last_three_posts"] ; then
				last_three_posts = posts_files.sort.reverse.first(3)
				home_page = load_home
				expected_posts_titles = home_page.css('.met_light h1')

				last_three_posts.each_with_index{ |file, index| 
					post_title = File.basename(file, ".md")
					post_data = load_markdown("_posts/#{post_title}")

					expect(expected_posts_titles[index].text.strip).to eq(post_data["title"])
				}
			end
		end
	end
end