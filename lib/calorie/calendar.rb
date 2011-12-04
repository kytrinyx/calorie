module Calorie

  class Calendar
    include WeeksInMonth

    attr_reader :days, :weeks, :year, :month, :data
    def initialize(year, month, data = {})
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

      (1..blank_days_at_start).each do |i|
        slices.unshift(Calorie::NullDay.new(first_day - i))
      end
      (1..blank_days_at_end).each do |i|
        slices.push(Calorie::NullDay.new(last_day + i))
      end

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
      unless @days_of_the_week
        @days_of_the_week ||= (0..6).map do |i|
          DayOfTheWeek.new(i)
        end
        if Calorie.configuration.week_starts_on? :monday
          @days_of_the_week.push(@days_of_the_week.shift)
        end
      end
      @days_of_the_week
    end

    def previous
      date = first_day.prev_month
      the_month = I18n.translate('calorie.months')[date.month-1]
      "#{the_month} #{date.year}"
    end

    def current
      date = first_day
      the_month = I18n.translate('calorie.months')[date.month-1]
      "#{the_month} #{date.year}"
    end

    def next
      date = first_day.next_month
      the_month = I18n.translate('calorie.months')[date.month-1]
      "#{the_month} #{date.year}"
    end
  end
end
