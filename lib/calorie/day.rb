module Calorie
  class Day

    def initialize(date = nil, data = nil)
      if date
        @date = date
      else
        @date = NullDate.new
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
      @date.is_a?(NullDate)
    end

    def today?
      @date == Date.today
    end
  end

  class NullDate
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
