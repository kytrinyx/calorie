require 'calorie'

describe Calorie do
  it "provides a simple presenter for a monthly calendar" do
    cal = Calorie.new(2010, 12, {25 => 'Christmas'})

    cal.each_day do |day|
      if day.number == 25
        day.data.should eq('Christmas')
      end
    end
  end
end
