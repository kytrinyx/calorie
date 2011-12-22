require 'calorie'

describe Calorie::Calendar do
  subject { Calorie::Calendar.new(2007, 12, {25 => 'Christmas'}) }

  context "with default configuration" do
    before(:each) { Calorie.config = nil }

    context "in the first week" do
      it "numbers the days correctly" do
        numbers = []
        subject.weeks.first.days.each do |day|
          numbers << day.number
        end
        numbers.should eq([nil, nil, nil, nil, nil, nil, 1])
      end

      it "dates the days correctly" do
        dates = []
        subject.weeks.first.days.each do |day|
          dates << day.date.to_s
        end
        dates.should eq(["2007-11-25", "2007-11-26", "2007-11-27", "2007-11-28", "2007-11-29", "2007-11-30", "2007-12-01"])
      end
    end

    context "in the last week" do
      it "numbers the days correctly" do
        numbers = []
        subject.weeks.last.days.each do |day|
          numbers << day.number
        end
        numbers.should eq([30, 31, nil, nil, nil, nil, nil])
      end

      it "dates the days correctly" do
        dates = []
        subject.weeks.last.days.each do |day|
          dates << day.date.to_s
        end
        dates.should eq(["2007-12-30", "2007-12-31", "2008-01-01", "2008-01-02", "2008-01-03", "2008-01-04", "2008-01-05"])
      end
    end

  end

  it "creates all the days" do
    numbers = []
    subject.days.each do |day|
      numbers << day.number
    end

    numbers.should eq((1..31).to_a)
  end

  it "hands out the data" do
    subject.days.each do |day|
      if day.number == 25
        day.data.should eq('Christmas')
      end
    end
  end

  describe "translation" do
    around :each do |example|
      I18n.with_locale(:xx) do
        example.run
      end
    end

    before :each do
      xx = {
        :calorie => {
          :days_of_the_week => ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'],
          :months => ['jan', 'fev', 'mar', 'avr', 'mai', 'jui', 'jui', 'aou', 'sep', 'oct', 'nov', 'dec']
        }
      }
      I18n.backend.store_translations(:xx, xx)
    end

    describe "monthly labels" do
      context "in january 2010" do
        subject { Calorie::Calendar.new(2010, 1, {}) }

        specify { subject.previous.should eq('dec 2009') }
        specify { subject.current.should eq('jan 2010') }
      end

      context "in december" do
        subject { Calorie::Calendar.new(2010, 12, {}) }

        specify { subject.next.should eq('jan 2011') }
      end
    end


    describe "weekdays" do
      subject { Calorie::Calendar.new(2010, 4, {}) }

      context "with default configuration" do
        before(:each) { Calorie.config = nil }

        specify { subject.days_of_the_week.map(&:label).should eq(%w(dimanche lundi mardi mercredi jeudi vendredi samedi)) }
      end

      context "with week starting on monday" do
        before :each do
          Calorie.configuration do |config|
            config.week_starts_on :monday
          end
        end

        specify { subject.days_of_the_week.map(&:label).should eq(%w(lundi mardi mercredi jeudi vendredi samedi dimanche)) }
      end
    end
  end

end
