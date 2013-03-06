require "heroku/command/base"
require "restclient"
require "date"

class Heroku::Command::Lunch < Heroku::Command::Base

  include Heroku::Helpers

  # list this weeks's lunches
  #
  # -w, --web   # open on the web
  #
  def index
    base_url = "http://lunch.herokuapp.com/"

    meals = json_decode(RestClient::Resource.new(base_url).get({:accept => :json}).body)

    if options[:web]
      require "launchy"

      Launchy.open(base_url)
    else
      styled_array(meals.map do |meal|
        [day_of_week(meal['date']), meal['summary']]
      end)
    end
  end

  private

  def day_of_week(date)
    Date.parse(date).strftime('%A')
  end

end
