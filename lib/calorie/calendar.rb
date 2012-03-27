module Calorie

  class Calendar

    attr_reader :days, :weeks, :year, :month, :data
    def initialize(year, month, data = {})
      @data = data
      @year = year
      @month = month
    end

    def days
      @days ||= each_day.map { |i| day(i) }
    end

    def weeks
      @weeks ||= WeeksInMonth.new(days)
    end

    def days_of_the_week
      @days_of_the_week ||= DaysOfTheWeek.new
    end

    def previous
      label_for(first_day.prev_month)
    end

    def current
      label_for(first_day)
    end

    def next
      label_for(first_day.next_month)
    end

    private
    def first_day
      @first_day ||= Date.new(year, month, 1)
    end

    def last_day
      @last_day ||= first_day.next_month.prev_day
    end

    def each_day
      (first_day.mday..last_day.mday).to_a
    end

    def label_for(date)
      "#{Calorie.month_name(date.month)} #{date.year}"
    end

    def day(i)
      date = Date.new(year, month, i)
      Calorie::Day.new(date, data[i])
    end

  end
end
