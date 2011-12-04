require 'calorie/day'
require 'calorie/week'

describe Calorie::Week do

  it "loops through the days" do
    days = [
      Calorie::NullDay.new,
      Calorie::NullDay.new,
      Calorie::Day.new(Date.new(2010, 6, 1), "the first"),
      Calorie::Day.new(Date.new(2010, 6, 2), "the second"),
      Calorie::Day.new(Date.new(2010, 6, 3), "the third"),
      Calorie::Day.new(Date.new(2010, 6, 4), "the fourth"),
      Calorie::Day.new(Date.new(2010, 6, 5), "the fifth"),
    ]

    numbers = []
    Calorie::Week.new(days).each_day do |day|
      numbers << day.number
    end

    numbers.should eq([nil, nil, 1, 2, 3, 4, 5])
  end
end
