require 'calorie/day'
require 'timecop'

describe Calorie::Day do

  context "during the weekend" do
    let(:day) { Calorie::Day.new(Date.new(2010, 6, 13), "hello, world") }

    it { expect(day.number).to eq(13) }
    it { expect(day.data).to eq("hello, world") }
    it { expect(day.weekend?).to be true }
    it { expect(day.blank?).to be false }

    context "on that particular day" do
      before :each do
        Timecop.freeze(Time.new(2010, 6, 13, 11, 40, 17))
      end

      after :each do
        Timecop.return
      end

      it { expect(day.today?).to be true }
    end

    context "on a different day" do
      before :each do
        Timecop.freeze(Time.new(2010, 6, 14, 20, 15, 47))
      end

      after :each do
        Timecop.return
      end

      it { expect(day.today?).to be false }
    end
  end

  context "midweek" do
    let(:day) { Calorie::Day.new(Date.new(2010, 6, 17), "so long, folks") }

    it { expect(day.number).to eq(17) }
    it { expect(day.data).to eq("so long, folks") }
    it { expect(day.weekend?).to be false }
    it { expect(day.blank?).to be false}
  end
end

describe Calorie::NullDay do
  let(:jan1) { Date.new(2010, 1, 1) }
  let(:day) { Calorie::NullDay.new(jan1) }

  it { expect(day.date).to eq(jan1) }
  it { expect(day.mday).to be_nil }
  it { expect(day.sunday?).to be false }
  it { expect(day.saturday?).to be false }
  it { expect(day.data).to be_nil }
end
