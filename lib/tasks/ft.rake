namespace :ft do
  
  desc "Poll the site to check for new or changed content"
  task :poll => :environment do

    BASE_URL = 'http://www.flyertalk.com/forum/mileage-run-discussion/930922-trick-negotiate-special-savings-lounge-thread'

    require 'mechanize'
    agent = Mechanize.new

    # Go to root page to get number of pages
    page = agent.get "#{BASE_URL}.html"
    last_page = page.link_with(text: /Last/).href.scan(/([\d]+)\.html/).first.first

    # Go to last page
    page = agent.get "#{BASE_URL}-#{last_page}.html"
    agent.page.encoding = 'windows-1252'

    # Remove all scripts
    page.root.xpath("//script").remove

    # Find all posets
    posts = page.root.xpath('.//td[regex(., "td_post_[\d]+")]', Class.new {
      def regex node_set, regex
        node_set.find_all { |node| node['id'] =~ /#{regex}/ }
      end
      }.new)

    # Write them to the screen
    posts.each do |p| 
      puts "=== POST ==="
      puts p.text.squish
    end

  end

end
