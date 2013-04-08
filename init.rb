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
    base_url = "https://lunch.herokai.com/"

    meals = json_decode(RestClient::Resource.new(base_url).get({:accept => :json}).body)

    if options[:web]
      require "launchy"

      Launchy.open(base_url)
    else
      styled_array(meals.map do |meal|
        [(meal['today'] ? '*' : ''), day_of_week(meal['date']), meal['summary']]
      end, :sort => false)
    end
  end

  private

  def day_of_week(date)
    Date.parse(date).strftime('%A')
  end

end
