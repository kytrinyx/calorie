module Calorie
  class Week

    attr_reader :days
    def initialize(days)
      @days = days
    end

    def each_day(&block)
      days.each {|day| block.call(day) }
    end
  end
end
