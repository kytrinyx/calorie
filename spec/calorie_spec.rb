require 'calorie'

describe Calorie do
  it "provides a simple decorator for a monthly calendar" do
    cal = Calorie.new(2010, 12, {25 => 'Christmas'})

    cal.days.each do |day|
      if day.number == 25
        expect(day.data).to eq('Christmas')
      end
    end
  end

  describe "configuration" do
    it "has a global config" do
      expect(Calorie.configuration).to eq(Calorie.configuration)
    end

    context "when unconfigured" do
      before :each do
        Calorie.config = nil
      end

      it "starts week on Sunday by default" do
        expect(Calorie.configuration.week_starts_on).to eq(:sunday)
      end

      it "knows when the week starts" do
        expect(Calorie.configuration.week_starts_on?(:sunday)).to be true
      end
    end

    context "when overriding defaults" do
      before :each do
        Calorie.configuration do |config|
          config.week_starts_on :monday
        end
      end

      it "has the correct start of the week" do
        expect(Calorie.configuration.week_starts_on).to eq(:monday)
      end

      it "knows when the week starts" do
        expect(Calorie.configuration.week_starts_on?(:monday)).to be true
      end
    end
  end
end
