require 'rest-client'
require 'json'
require 'pry'

def get_character_info(character_name)
  #returns a hash containing info on a character
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  
  char = response_hash['results'].find do |character| 
    character['name'] = character_name
  end
  char
end

def get_films_a_character_has_been_in(character_info)
  #returns a hash of films that a character has been in 
  film_urls = character_info['films']
  film_info = []
  
  film_urls.each do |url|
    film_info << JSON.parse(RestClient.get(url))
  end
  film_info
end

# def get_character_movies_from_api(character_name)
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
# end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  # title
  # releasedate
  # director
  # opening_crawl
  films.each do |film|
    puts 'TITLE'
    puts '     ' + film['title']
    puts 'RELEASE DATE'
    puts '     ' + film['release_date']
    puts 'DIRECTOR'
    puts '     ' + film['director']
    puts 'INTRO'
    puts '     ' + film['opening_crawl'][0..50].chomp
    puts '*' * 50
  end
end

def show_character_movies(character)
  char_info = get_character_info(character)
  films = get_films_a_character_has_been_in(char_info)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?

# can you split it up into helper methods?
