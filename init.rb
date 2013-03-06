require "heroku/command/base"
require "restclient"
require "date"

class Heroku::Command::Lunch < Heroku::Command::Base

  include Heroku::Helpers

  # list this weeks's lunches
  #
  # -s, --short    # print just meals without descriptions
  #
  def index
    meals = json_decode(RestClient::Resource.new("http://lunch.herokuapp.com/").get({:accept => :json}).body)

    meals.each do |meal|
      if options[:short]
        puts "#{Date.parse(meal['date']).strftime("%A")}: #{meal['summary']}"
      else
        puts "#{Date.parse(meal['date']).strftime("%A")}: #{meal['summary']} #{meal['description']}\n"
      end
    end
  end

end
