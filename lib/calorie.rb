require "calorie/version"

require 'date'

require 'calorie/weeks_in_month'
require 'calorie/calendar'
require 'calorie/week'
require 'calorie/day'

module Calorie

  def self.new(year, month, data)
    Calendar.new(year, month, data)
  end
end
