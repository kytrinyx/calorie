require 'calorie/day'
require 'calorie/week'

describe Calorie::Week do
  let(:thursday) { Calorie::Day.new(Date.new(2010, 6, 3)) }
  let(:days) {
    [
      Calorie::NullDay.new(Date.new(2010, 5, 29)),
      Calorie::NullDay.new(Date.new(2010, 5, 31)),
      Calorie::Day.new(Date.new(2010, 6, 1)),
      Calorie::Day.new(Date.new(2010, 6, 2)),
      thursday,
      Calorie::Day.new(Date.new(2010, 6, 4)),
      Calorie::Day.new(Date.new(2010, 6, 5)),
    ]
  }

  let(:week) { Calorie::Week.new(days) }

  it "loops through the days" do
    numbers = []
    week.days.each do |day|
      numbers << day.number
    end

    expect(numbers).to eq([nil, nil, 1, 2, 3, 4, 5])
  end

  it "can find its Thursday" do
    expect(week.thursday).to eq(thursday)
  end
end
