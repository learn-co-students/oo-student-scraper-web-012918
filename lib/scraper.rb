require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = doc.css(".roster-cards-container .student-card")


    scraped_students = []

    student_array.each do |student|
      scraped_student = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      scraped_students << scraped_student
    end

    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    twitter = ""
    github = ""
    linkedin = ""
    blog = ""

    #binding.pry
    links = doc.css(".social-icon-container a")
    links.each do |link|
      if link["href"].include?("twitter")
        twitter = link["href"]
      elsif link["href"].include?("github")
        github = link["href"]
      elsif link["href"].include?("linkedin")
        linkedin = link["href"]
      elsif link["href"].include?(".com")
        blog = link["href"]
      end
    end

    scraped_student = {
      :twitter => twitter!= "" ? twitter : "",
      :linkedin => linkedin!= "" ? linkedin : "",
      :github => github!= "" ? github : "",
      :blog => blog!= "" ? blog : "",
      :profile_quote => doc.css(".profile-quote").text,
      :bio => doc.css(".description-holder p").text
    }
    scraped_student.delete_if {|key, value| value == ""}

    #binding.pry
  end

end

#name = student.css(".student-name").text
#location = student.css(".student-location").text
#profile_url = student.css("a").attribute("href").value


#links = doc.css(".social-icon-container")
#twitter
#linkedin
#github
#blog =
#profile_quote = doc.css(".profile-quote").text
#bio = doc.css(".bio-content").text

# :twitter => twitter!= "" ? twitter : "no twitter supplied",
# :linkedin => linkedin!= "" ? linkedin : "no linkedin supplied",
# :github => github!= "" ? github : "no github supplied" ,
# :blog => blog!= "" ? blog : "no blog supplied",

# twitter = doc.css(".social-icon-container a")[0].attribute("href").value
# # does_exist(twitter)
# linkedin = doc.css(".social-icon-container a")[1].attribute("href").value
# # does_exist(linkedin)
# #github = doc.css(".social-icon-container a")[2].attribute("href").value
# # does_exist(github)
# #binding.pry
# if doc.css(".social-icon-container a")[2] != []
#   github = doc.css(".social-icon-container a")[2].attribute("href").value
# else
#   github = "no attribute supplied"
# end

#binding.pry

# def does_exist(link)
#   if link.include?(link.to_s)
#     link = link
#   else
#     link = "not supplied by user"
#   end
# end

# blog = doc.css(".social-icon-container a")[3].attribute("href").value
# # does_exist(blog)
