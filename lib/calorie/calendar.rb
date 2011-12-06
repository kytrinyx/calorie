module Calorie

  class Calendar

    attr_reader :days, :weeks, :year, :month, :data
    def initialize(year, month, data = {})
      @data = data
      @year = year
      @month = month
      initialize_days
      @weeks = WeeksInMonth.new(days).weeks
    end

    def first_day
      @first_day ||= Date.new(year, month, 1)
      @first_day
    end

    def last_day
      @last_day ||= first_day.next_month.prev_day
      @last_day
    end

    def initialize_days
      @days = []
      (first_day.mday..last_day.mday).map do |i|
        date = Date.new(year, month, i)
        @days << Calorie::Day.new(date, data[i])
      end
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
      Calorie.label_for(first_day.prev_month)
    end

    def current
      Calorie.label_for(first_day)
    end

    def next
      Calorie.label_for(first_day.next_month)
    end
  end
end
