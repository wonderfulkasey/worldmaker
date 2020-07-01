require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

      url = https://open5e.com/magicitems/magicitem-list/search/

      html = open(url)
      
      doc = Nokogiri::HTML(html)

      binding.pry

end

scrape = Scraper.new