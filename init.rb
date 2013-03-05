require "heroku/command/base"
require "restclient"
require "date"

class Heroku::Command::Lunch < Heroku::Command::Base

  include Heroku::Helpers

  # output this weeks's lunches
  #
  def index
    meals = json_decode(RestClient::Resource.new("http://lunch.herokuapp.com/").get({:accept => :json}).body)

    meals.each do |meal|
      puts "#{ Date.parse(meal['date']).strftime("%A") }: #{ meal['summary'] }"
    end
  end

end
