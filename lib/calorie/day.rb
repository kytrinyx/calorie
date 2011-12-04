module Calorie
  class Day

    attr_reader :date
    def initialize(date = nil, data = nil)
      if date
        @date = date
      else
        @date = NullDay.new
      end
      @data = data
    end

    def weekend?
      @date.sunday? || @date.saturday?
    end

    def number
      @date.mday
    end

    def data
      @data
    end

    def blank?
      @date.is_a?(NullDay)
    end

    def today?
      @date == Date.today
    end
  end

  class NullDay
    attr_reader :date
    def initialize(date = nil)
      @date = date
    end

    def sunday?
      false
    end

    def saturday?
      false
    end

    def mday
    end
  end
end
