require 'calorie/day'
require 'timecop'

describe Calorie::Day do

  context "during the weekend" do
    subject { Calorie::Day.new(Date.new(2010, 6, 13), "hello, world") }

    its(:number) { should eq(13) }
    its(:data) { should eq("hello, world") }
    its(:weekend?) { should be_true }
    its(:blank?) { should be_false}

    context "on that particular day" do
      before :each do
        Timecop.freeze(Time.new(2010, 6, 13, 11, 40, 17))
      end

      after :each do
        Timecop.return
      end

      its(:today?) { should be_true }
    end

    context "on a different day" do
      before :each do
        Timecop.freeze(Time.new(2010, 6, 14, 20, 15, 47))
      end

      after :each do
        Timecop.return
      end

      its(:today?) { should be_false }
    end
  end

  context "midweek" do
    subject { Calorie::Day.new(Date.new(2010, 6, 17), "so long, folks") }

    its(:number) { should eq(17) }
    its(:data) { should eq("so long, folks") }
    its(:weekend?) { should be_false }
    its(:blank?) { should be_false}
  end

  context "a null day" do
    subject { Calorie::Day.new }
    its(:blank?) { should be_true }
    its(:number) { should be_nil }
    its(:weekend?) { should be_false }
    its(:data) { should be_nil }
  end
end

describe Calorie::NullDate do
  its(:mday) { should be_nil }
  its(:sunday?) { should be_false }
  its(:saturday?) { should be_false }
end
