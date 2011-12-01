module Calorie
  class DayOfTheWeek
    class << self
      def day_names
        I18n.translate('calorie.days_of_the_week')
      end
    end

    def initialize(day_of_the_week)
      @day_of_the_week = day_of_the_week
    end

    def label
      DayOfTheWeek.day_names[@day_of_the_week]
    end

    def weekend?
      [0, 6].include?(@day_of_the_week)
    end
  end
end
