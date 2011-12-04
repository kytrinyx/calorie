module Calorie
  class Week

    attr_reader :days
    def initialize(days)
      @days = days
    end

    def each_day(&block)
      days.each {|day| block.call(day) }
    end

    def number
      (thursday.date.yday / 7.0).ceil
    end

    def thursday
      days.each do |day|
        return day if day.date.thursday?
      end
    end
  end
end
