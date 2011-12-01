require 'calorie'

describe Calorie::DayOfTheWeek do
  around :each do |example|
    I18n.with_locale(:xx) do
      example.run
    end
  end

  before :each do
    xx = { :calorie => { :days_of_the_week => ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'], } }
    I18n.backend.store_translations(:xx, xx)
  end

  it "has a label" do
    Calorie::DayOfTheWeek.new(0).label.should eq('dimanche')
  end

  [0, 6].each do |i|
    specify { Calorie::DayOfTheWeek.new(i).weekend?.should be_true }
  end

  (1..5).each do |i|
    specify { Calorie::DayOfTheWeek.new(i).weekend?.should be_false }
  end

end
