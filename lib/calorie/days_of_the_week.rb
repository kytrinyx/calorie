module Calorie
  class DaysOfTheWeek
    include Enumerable

    def initialize
      @days = (0..6).map do |i|
        DayOfTheWeek.new(i)
      end
      if Calorie.configuration.week_starts_on? :monday
        @days.push(@days.shift)
      end
    end

    def each
      @days.each do |day| yield day end
    end
  end
end
