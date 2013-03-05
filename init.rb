require "heroku/command/base"

class Heroku::Command::Lunch < Heroku::Command::Base

  include Heroku::Helpers

  # output this weeks's lunches
  #
  def index
    puts get_meals
  end

  private

  def get_meals
    result = RestClient::Resource.new('http://lunch.herokuapp.com/').get.body
    json_decode(result)['result']
  end

end
