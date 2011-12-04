require 'calorie'

describe Calorie::Calendar do
  subject { Calorie::Calendar.new(2010, 12, {25 => 'Christmas'}) }

  context "with default configuration" do
    before(:each) { Calorie.config = nil }

    context "in the first week" do
      it "numbers the days correctly" do
        numbers = []
        subject.weeks.first.each_day do |day|
          numbers << day.number
        end
        numbers.should eq([nil, nil, nil] + (1..4).to_a)
      end

      it "dates the days correctly" do
        dates = []
        subject.weeks.first.each_day do |day|
          dates << day.date.to_s
        end
        dates.should eq(["2010-11-28", "2010-11-29", "2010-11-30", "2010-12-01", "2010-12-02", "2010-12-03", "2010-12-04"])
      end
    end

    context "in the last week" do
      it "numbers the days correctly" do
        numbers = []
        subject.weeks.last.each_day do |day|
          numbers << day.number
        end
        numbers.should eq((26..31).to_a + [nil])
      end

      it "dates the days correctly" do
        dates = []
        subject.weeks.last.each_day do |day|
          dates << day.date.to_s
        end
        dates.should eq(["2010-12-26", "2010-12-27", "2010-12-28", "2010-12-29", "2010-12-30", "2010-12-31", "2011-01-01"])
      end
    end

  end

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

  context "when week starts on sunday" do
    before(:each) { Calorie.config = nil }

    describe "first day falls on" do
      {
        2003 => 2,
        2004 => 4,
        2005 => 5,
        2006 => 6,
        2007 => 0,
        2008 => 2
      }.each do |year, offset|
        it "#{offset} in #{year}" do
          cal = Calorie::Calendar.new(year, 4, {})
          cal.first_day_falls_on.should eq(offset)
        end
      end
    end
  end

  context "when week starts on monday" do
    before :each do
      Calorie.configuration do |config|
        config.week_starts_on :monday
      end
    end

    describe "first day falls on" do
      {
        2003 => 3,
        2004 => 5,
        2005 => 6,
        2006 => 0,
        2007 => 1,
        2008 => 3
      }.each do |year, offset|
        it "#{offset} in #{year}" do
          cal = Calorie::Calendar.new(year, 5, {})
          cal.first_day_falls_on.should eq(offset)
        end
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
