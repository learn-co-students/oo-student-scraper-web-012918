require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def scrape_greatest_hits(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #binding.pry

    scraped_restaurants = []

    restaurant_array = doc.css(".post__section .spot-block")
    restaurant_array.each do |restaurant|
      restaurant_hash = {
        :name => restaurant.css(".spot-block__title a h3").text,
        #:location => restaurant.css(".spot-block__neighborhoods a").text.gsub("\n", ""),
        :address => restaurant.css("small").text,
        :description => restaurant.css(".spot-block__description p").text,
      }
      scraped_restaurants << restaurant_hash
    end
    #binding.pry
    scraped_restaurants
  end


  def random_greatest_hits_full(greatest_hits_array)
    #binding.pry
    tonight_hash = greatest_hits_array.sample
    puts "Tonight, you're going to #{tonight_hash[:name]}. It is located at #{tonight_hash[:address]} Here's what we think: #{tonight_hash[:description]}."
    #greatest_hits_array.sample
    #binding.pry
  end

  def random_greatest_hits_sample(greatest_hits_array)
    puts "1. #{greatest_hits_array.sample[:name]}"
    puts "2. #{greatest_hits_array.sample[:name]}"
    puts "3. #{greatest_hits_array.sample[:name]}"
    #binding.pry
  end

end

infatuation = Scraper.new
scraped = infatuation.scrape_greatest_hits("https://www.theinfatuation.com/new-york/guides/best-restaurants-in-nyc-greatest-hits-list")
# infatuation.random_greatest_hits(scraped)
# infatuation.random_greatest_hits_sample(scraped)
# binding.pry
# "hello"
