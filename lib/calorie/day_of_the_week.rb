module Calorie
  class DayOfTheWeek
    def initialize(day_of_the_week)
      @day_of_the_week = day_of_the_week
    end

    def label
      @label ||= Calorie.day_names[@day_of_the_week]
    end

    def weekend?
      [0, 6].include?(@day_of_the_week)
    end
  end
end
