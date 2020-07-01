require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

    def self.fetch(name)
        website = "www.dnd5eapi.co/api/spells/#{name}"
        begin
        response = RestClient.get(website)
      rescue
        puts "-----------------------------------------".colorize(:red)
        puts "Sorry, that monster doesn't exist!".colorize(:red)
        puts "Please enter a new monster.".colorize(:red)
        puts "-----------------------------------------".colorize(:red)
        input=gets.chomp.downcase
        self.fetch(input)
      else
        response = JSON.parse(response)

          hash  = {
          "name" => response["name"],
          "desc" => response["desc"],
          "page" => response["page"],
          "material" => response["material"],
          "classes" => response["classes"],
          "url" => response["url"]
        }

          DND::Monster.new(hash)
        end
    end

end