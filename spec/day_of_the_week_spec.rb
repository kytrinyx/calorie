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
    expect(Calorie::DayOfTheWeek.new(0).label).to eq('dimanche')
  end

  [0, 6].each do |i|
    specify { expect(Calorie::DayOfTheWeek.new(i).weekend?).to be true }
  end

  (1..5).each do |i|
    specify { expect(Calorie::DayOfTheWeek.new(i).weekend?).to be false }
  end

end
