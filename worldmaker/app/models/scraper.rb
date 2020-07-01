require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
       def scrape
             url = 'https://open5e.com/magicitems/magicitem-list/search/'
             html = open(url)
             doc = Nokogiri::HTML(html)

             name = doc.css('.list').each do |row|


       end
end

scrape = Scraper.new