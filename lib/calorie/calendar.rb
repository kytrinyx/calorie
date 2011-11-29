module Calorie

  class Calendar
    include WeeksInMonth

    attr_reader :days, :weeks, :year, :month, :data
    def initialize(year, month, data)
      @data = data
      @year = year
      @month = month
      initialize_days
      initialize_weeks
    end

    def first_day
      @first_day ||= Date.new(year, month, 1)
      @first_day
    end

    def last_day
      @last_day ||= first_day.next_month.prev_day
      @last_day
    end

    def days_in_month
      days.size
    end

    def first_day_falls_on
      if Calorie.configuration.week_starts_on?(:monday)
        (first_day.wday - 1) % 7
      else
        first_day.wday
      end
    end

    def initialize_days
      @days = []
      (first_day.mday..last_day.mday).map do |i|
        date = Date.new(year, month, i)
        @days << Calorie::Day.new(date, data[i])
      end
    end

    def initialize_weeks
      @weeks = []
      padded_days = days_for_slicing
      number_of_weeks.times do
        @weeks << Calorie::Week.new(padded_days.slice!(0..6))
      end
    end

    def days_for_slicing
      slices = days.clone

      blank_days_at_start.times { slices.unshift(Calorie::Day.new) }
      blank_days_at_end.times { slices.push(Calorie::Day.new) }

      slices
    end

    def blank_days_at_start
      first_day_falls_on
    end

    def blank_days_at_end
      (blank_days_at_start + days_in_month) % 7
    end

    def days_in_month
      last_day.mday
    end

    def each_day(&block)
      days.each {|day| block.call(day) }
    end

    def days_of_the_week
      if Calorie.configuration.week_starts_on? :monday
        %w(Mo Tu We Th Fr Sa Su)
      else
        %w(Su Mo Tu We Th Fr Sa)
      end
    end
  end
end
