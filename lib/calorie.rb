require "calorie/version"

require 'date'
require 'i18n'

require 'calorie/weeks_in_month'
require 'calorie/day_of_the_week'
require 'calorie/calendar'
require 'calorie/week'
require 'calorie/day'

module Calorie

  class Config

    def initialize
      week_starts_on :sunday
    end

    def week_starts_on(day = nil)
      @week_starts_on = day if day
      @week_starts_on
    end

    def week_starts_on?(day)
      day == @week_starts_on
    end

  end

  class << self
    def configuration
      @config ||= Config.new

      yield @config if block_given?

      @config
    end

    def config=(configuration)
      @config = configuration
    end

    def new(year, month, data = {})
      Calendar.new(year, month, data)
    end
  end

end
