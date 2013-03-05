require "heroku/command/base"

class Heroku::Command::Lunch < Heroku::Command::Base

  include Heroku::Helpers

  # output today's lunch
  #
  def index
    puts get_meals.first
  end

  # output this week's lunch
  #
  def week
    get_meals.each { |meal|
      puts meal
    }
  end

  private

  def get_meals
    result = RestClient::Resource.new('https://ohiru.herokai.com/meals').get.body
    json_decode(result)['result']
  end

end
