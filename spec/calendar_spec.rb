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

  context "with default configuration" do
    before :each do
      Calorie.config = nil
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
  end

  context "when week starts on sunday" do
    before :each do
      Calorie.config = nil
    end

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

    before :each do
      xx = {
        :calorie => {
          :days_of_the_week => ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi']
        }
      }
      I18n.backend.store_translations(:xx, xx)
    end

    it "works with default configuration" do
      Calorie.config = nil

      I18n.with_locale(:xx) do
        cal = Calorie::Calendar.new(2010, 4, {})
        cal.days_of_the_week.should eq(%w(dimanche lundi mardi mercredi jeudi vendredi samedi))
      end
    end

    it "works when week starts on monday" do

      Calorie.configuration do |config|
        config.week_starts_on :monday
      end

      I18n.with_locale(:xx) do
        cal = Calorie::Calendar.new(2010, 4, {})
        cal.days_of_the_week.should eq(%w(lundi mardi mercredi jeudi vendredi samedi dimanche))
      end
    end

  end

end
