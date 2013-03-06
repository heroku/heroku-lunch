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

    if options[:short]
      styled_array(meals.map do |meal|
        [Date.parse(meal['date']).strftime("%A"), meal['summary']]
      end)
    else
      puts "Nothing to see here yet, rerun command with -s."
    end
  end

end
