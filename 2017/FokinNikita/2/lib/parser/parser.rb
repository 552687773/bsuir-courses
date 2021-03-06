require 'mechanize'
require_relative '../battle/battle'

class Parser
  SONGS_LIST = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'.freeze
  attr_accessor :links

  def initialize
    @links = []
    @agent = Mechanize.new
  end

  def get_links
    page = @agent.get(SONGS_LIST)
    page.links_with(href: /King-of-the-dot-/).each do |battle_link|
      @links << battle_link
    end
    page.links_with(href: /page=/).each do |next_page|
      page = next_page.click
      page.links_with(href: /King-of-the-dot-/).each do |battle_link|
        @links << battle_link
      end
    end
  end

  def get_battles(name)
    battle_list = []
    battles = if name.nil?
                @links
              else
                @links.select do |link|
                  link.text.scan(name).size >= 1
                end
              end
    battles.each do |link|
      page = link.click
      title = page.search('.header_with_cover_art-primary_info-title').text
      text = page.search('.lyrics').text
      battle = Battle.new(title, link.href, text)
      battle_list << battle
    end
    battle_list
  end
end
