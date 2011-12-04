require 'calorie/day'
require 'calorie/week'

describe Calorie::Week do

  it "loops through the days" do
    days = [
      Calorie::NullDay.new,
      Calorie::NullDay.new,
      Calorie::Day.new(Date.new(2010, 6, 1)),
      Calorie::Day.new(Date.new(2010, 6, 2)),
      Calorie::Day.new(Date.new(2010, 6, 3)),
      Calorie::Day.new(Date.new(2010, 6, 4)),
      Calorie::Day.new(Date.new(2010, 6, 5)),
    ]

    numbers = []
    Calorie::Week.new(days).each_day do |day|
      numbers << day.number
    end

    numbers.should eq([nil, nil, 1, 2, 3, 4, 5])
  end
end
