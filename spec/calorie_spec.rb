require 'calorie'

describe Calorie do
  it "provides a simple decorator for a monthly calendar" do
    cal = Calorie.new(2010, 12, {25 => 'Christmas'})

    cal.days.each do |day|
      if day.number == 25
        day.data.should eq('Christmas')
      end
    end
  end

  describe "configuration" do
    it "has a global config" do
      Calorie.configuration.should eq(Calorie.configuration)
    end

    context "when unconfigured" do
      before :each do
        Calorie.config = nil
      end

      it "starts week on Sunday by default" do
        Calorie.configuration.week_starts_on.should eq(:sunday)
      end

      it "knows when the week starts" do
        Calorie.configuration.week_starts_on?(:sunday).should be_true
      end
    end

    context "when overriding defaults" do
      before :each do
        Calorie.configuration do |config|
          config.week_starts_on :monday
        end
      end

      it "has the correct start of the week" do
        Calorie.configuration.week_starts_on.should eq(:monday)
      end

      it "knows when the week starts" do
        Calorie.configuration.week_starts_on?(:monday).should be_true
      end
    end
  end
end
