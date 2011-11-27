module Calorie
  module WeeksInMonth

    def number_of_weeks
      ((days_in_month + first_day_falls_on) / 7.0).ceil
    end

  end
end
