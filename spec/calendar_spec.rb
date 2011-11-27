require 'calorie'

describe Calorie::Calendar do
  subject { Calorie::Calendar.new(2010, 12, {25 => 'Christmas'}) }

  it "creates all the days" do
    numbers = []
    subject.each_day do |day|
      numbers << day.number
    end

    numbers.should eq((1..31).to_a)
  end

  it "hands out the data" do
    subject.each_day do |day|
      if day.number == 25
        day.data.should eq('Christmas')
      end
    end
  end

  it "gets the first week right" do
    numbers = []
    subject.weeks.first.each_day do |day|
      numbers << day.number
    end
    numbers.should eq([nil, nil, nil] + (1..4).to_a)
  end

  it "gets the last week right" do
    numbers = []
    subject.weeks.last.each_day do |day|
      numbers << day.number
    end
    numbers.should eq((26..31).to_a + [nil])
  end

  it "has labels for the days of the week" do
    subject.days_of_the_week.should eq(%w(Su Mo Tu We Th Fr Sa))
  end
end
