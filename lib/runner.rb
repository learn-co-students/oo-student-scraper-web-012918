require_relative "./scraper.rb"

def welcome
  puts "Welcome to TextRex, I'll tell you where to eat tonight"
  sleep(1.5)
  puts "Do you want some options, or are you feeling lucky?"
end

def prompt_user
  puts "Type 'options' for some options or 'lucky' if you are feeling lucky"
end

def get_user_input
  response = gets.chomp
end

def choose?
  prompt_user
  response = get_user_input
  if response == "options"
    sleep(0.5)
    options
  elsif response == "lucky"
    sleep(0.5)
    lucky
  else
     invalid_command
  end
end

def options
  infatuation = Scraper.new
  scraped = infatuation.scrape_greatest_hits("https://www.theinfatuation.com/new-york/guides/best-restaurants-in-nyc-greatest-hits-list")
  infatuation.random_greatest_hits_sample(scraped)
end

def lucky
  infatuation = Scraper.new
  scraped = infatuation.scrape_greatest_hits("https://www.theinfatuation.com/new-york/guides/best-restaurants-in-nyc-greatest-hits-list")
  infatuation.random_greatest_hits_full(scraped)
end


def end_game
  sleep(1)
  puts "Happy dining!"
end


def invalid_command
  puts "Please enter a valid command!"
  prompt_user
  get_user_input
end

#####################################################
# get every test to pass before coding runner below #
#####################################################

def runner
  welcome
  sleep(1.5)
  choose?
  end_game
end

runner
