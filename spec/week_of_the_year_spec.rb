require 'calorie'

describe "Week number" do

  context "in the first week of january" do

    {2005 => 53, 2006 => 52, 2007 => 1, 2008 => 1, 2009 => 1, 2010=> 53}.each do |year, week_number|
      context "with week starting monday" do
        before :each do
          Calorie.configuration do |config|
            config.week_starts_on :monday
          end
        end

        specify "in #{year}" do
          Calorie.new(year, 1).weeks.first.number.should eq(week_number)
        end
      end
    end

    {2005 => 53, 2006 => 1, 2007 => 1, 2008 => 1, 2009 => 1, 2010=> 53}.each do |year, week_number|
      # this is a bit far-fetched, as the iso-8601 week always starts on a Monday.
      # on the other hand, the numbering scheme is defined as week 1 being the week
      # that has the year's first Thursday in it, so it kind of works.
      context "with week starting sunday" do
        before :each do
          Calorie.configuration do |config|
            config.week_starts_on :sunday
          end
        end

        specify "in #{year}" do
          Calorie.new(year, 1).weeks.first.number.should eq(week_number)
        end
      end
    end
  end

  describe "in the last week of december" do
    {2004 => 53, 2005 => 52, 2006 => 1, 2007 => 1, 2008 => 1, 2009 => 53, 2010 => 52}.each do |year, week_number|
      context "with week starting sunday" do
        before :each do
          Calorie.configuration do |config|
            config.week_starts_on :sunday
          end
        end

        specify "in #{year}" do
          Calorie.new(year, 12).weeks.last.number.should eq(week_number)
        end
      end
    end

    context "with week starting monday" do
      {2004 => 53, 2005 => 52, 2006 => 52, 2007 => 1, 2008 => 1, 2009 => 53, 2010 => 52}.each do |year, week_number|
        before :each do
          Calorie.configuration do |config|
            config.week_starts_on :monday
          end
        end

        specify "in #{year}" do
          Calorie.new(year, 12).weeks.last.number.should eq(week_number)
        end
      end
    end
  end
end
