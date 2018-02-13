PAGES_TO_POLL = 5

namespace :ft do
  
  desc "Poll the site to check for new or changed content"
  task :poll => :environment do

    BASE_URL = 'http://www.flyertalk.com/forum/mileage-run-discussion/930922-trick-negotiate-special-savings-lounge-thread'

    require 'mechanize'
    agent = Mechanize.new

    # Go to root page to get number of pages
    page = agent.get "#{BASE_URL}.html"
    last_page = page.link_with(text: /Last/).href.scan(/([\d]+)\.html/).first.first.to_i

    # Process the last given number of pages
    last_page.downto(last_page - PAGES_TO_POLL + 1) do |pagenum|

      # Go to given page
      page = agent.get "#{BASE_URL}-#{pagenum}.html"
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

      # Get all authors
      authors = []
      posts.search('.bigusername').each do |a|
        authors << a.text
      end
      # p authors

      # Find all post content
      msgs = posts.xpath('.//div[regex(., "td_post_[\d]+")]', Class.new {
        def regex node_set, regex
          node_set.find_all { |node| node['id'] =~ /#{regex}/ }
        end
        }.new)
      # p msgs

      # Find all post ids
      post_ids = posts.xpath('.//a[regex(., "postcount[\d]+")]', Class.new {
        def regex node_set, regex
          node_set.find_all { |node| node['id'] =~ /#{regex}/ }
        end
        }.new)
      # p post_ids

      throw [authors, msgs] if authors.length != msgs.length
      throw [msgs, post_ids] if msgs.length != post_ids.length

      # Create the posts based on the text
      # If it's an edit, it will create a new post entry
      msgs.each_with_index do |msg,i|

        # Create an author if necessary
        a = Author.where(name: authors[i]).first_or_create
        p a

        # Removed any "Last edited by..."
        # Because this changes with times and dates and creates duplicates
        text = msg.text.squish
        text.gsub!(/ Last edited.+$/, '')

        # Create the post
        pe = PostEntry.where(
          author_id: a, 
          post_id: post_ids[i].text.to_i,
          content: text
          ).first_or_create
        p pe

      end

    end

  end

end
