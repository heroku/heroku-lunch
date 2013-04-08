require "heroku/command/base"
require "restclient"
require "date"

# list this weeks's Heroku lunches
#
class Heroku::Command::Lunch < Heroku::Command::Base

  BASE_URL = "https://lunch.herokai.com/"

  include Heroku::Helpers

  # lunch
  #
  # list this weeks's lunches
  #
  def index
    meals = json_decode(RestClient::Resource.new(BASE_URL).get({:accept => :json}).body)

    styled_array(meals.map do |meal|
      [(meal['today'] ? '*' : ''), day_of_week(meal['date']), meal['summary']]
    end, :sort => false)
  end

  # lunch:open
  #
  # open the lunch menu in your browser
  #
  def open
    require "launchy"

    Launchy.open(BASE_URL)
  end

  private

  def day_of_week(date)
    Date.parse(date).strftime('%A')
  end

end
