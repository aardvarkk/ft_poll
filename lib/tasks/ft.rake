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

    # Find all outer posts (get titles, etc.)
    posts = page.root.xpath('.//div[regex(., "edit[\d]+")]', Class.new {
      def regex node_set, regex
        node_set.find_all { |node| node['id'] =~ /#{regex}/ }
      end
      }.new)
    # p posts
    authors = []
    posts.search('.bigusername').each do |a|
      authors << a.text
    end
    # p authors

    # Find all post content
    msgs = posts.xpath('.//td[regex(., "td_post_[\d]+")]', Class.new {
      def regex node_set, regex
        node_set.find_all { |node| node['id'] =~ /#{regex}/ }
      end
      }.new)
    # p msgs

    throw [authors, msgs] if authors.length != msgs.length

    # Create the posts based on the text
    # If it's an edit, it will create a new post entry
    msgs.each_with_index do |msg,i|

      # Create an author if necessary
      a = Author.where(name: authors[i]).first_or_create
      p a

      # Create the post
      pe = PostEntry.where(author_id: a, content: msg.text.squish).first_or_create
      p pe

    end

  end

end
