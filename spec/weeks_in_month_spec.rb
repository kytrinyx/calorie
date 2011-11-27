require 'calorie/weeks_in_month'

describe Calorie::WeeksInMonth do
  let(:cal) { stub.extend(Calorie::WeeksInMonth) }

  context "with a 28 day month" do
    before :each do
      cal.stub(:days_in_month => 28)
    end

    it "has 4 weeks when first day is Sunday" do
      cal.stub(:first_day_falls_on => 0)
      cal.number_of_weeks.should eq(4)
    end

    it "has 5 weeks when first day is Monday" do
      cal.stub(:first_day_falls_on => 1)
      cal.number_of_weeks.should eq(5)
    end

    it "has 5 weeks when first day is Saturday" do
      cal.stub(:first_day_falls_on => 6)
      cal.number_of_weeks.should eq(5)
    end
  end

  context "with a 29 day month" do
    before :each do
      cal.stub(:days_in_month => 29)
    end

    it "has 5 weeks when first day is Sunday" do
      cal.stub(:first_day_falls_on => 0)
      cal.number_of_weeks.should eq(5)
    end

    it "has 5 weeks when first day is Monday" do
      cal.stub(:first_day_falls_on => 1)
      cal.number_of_weeks.should eq(5)
    end

    it "has 5 weeks when first day is Saturday" do
      cal.stub(:first_day_falls_on => 6)
      cal.number_of_weeks.should eq(5)
    end

  end

  context "with a 30 day month" do
    before :each do
      cal.stub(:days_in_month => 30)
    end

    it "has 5 weeks when first day is Sunday" do
      cal.stub(:first_day_falls_on => 0)
      cal.number_of_weeks.should eq(5)
    end

    it "has 5 weeks when first day is Friday" do
      cal.stub(:first_day_falls_on => 5)
      cal.number_of_weeks.should eq(5)
    end

    it "has 6 weeks when first day is Saturday" do
      cal.stub(:first_day_falls_on => 6)
      cal.number_of_weeks.should eq(6)
    end
  end

  context "with a 31 day month" do
    before :each do
      cal.stub(:days_in_month => 31)
    end

    it "has 5 weeks when first day is Sunday" do
      cal.stub(:first_day_falls_on => 0)
      cal.number_of_weeks.should eq(5)
    end

    it "has 5 weeks when first day is Thursday" do
      cal.stub(:first_day_falls_on => 4)
      cal.number_of_weeks.should eq(5)
    end

    it "has 6 weeks when first day is Friday" do
      cal.stub(:first_day_falls_on => 5)
      cal.number_of_weeks.should eq(6)
    end

    it "has 6 weeks when first day is Saturday" do
      cal.stub(:first_day_falls_on => 6)
      cal.number_of_weeks.should eq(6)
    end
  end
end
