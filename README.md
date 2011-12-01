# Calorie

A calendar is a calendar is a calendar.

## Requirements

This uses the ruby core `Date` library.

In other words, rails is *not* required.

## Usage

Create a hash that uses the day of the month as the key.
The data can be anything; only your code will be interacting with it.

      data = {
        1 => thing,
        2 => different_thing,
        3 => nil,
        4 => medium_sized_thing,
        5 => complicated_thing,
        6 => nil,
        # ... etc
      }

Create a presenter for a month by sending in `year`, `month`, and the data:

      cal = Calorie.new(2010, 6, data)

In your view, you can style it however you wish.

      # previous month, e.g. December 2009
      cal.previous

      # current month, e.g. January 2010
      cal.current

      # next month, e.g. February 2010
      cal.next

      cal.days_of_the_week do |label|
        label
      end

      cal.each_week do |week|
        week.each_day do |day|
          unless day.blank?
            # the day of the month is day.number
            # do stuff with day.data
            if day.today?
              # omg, it's RIGHT NOW
            end
          end
        end
      end

If you don't need to lay it out by week, you can also iterate straight through the days (though I'm not sure why you'd use Calorie for this):

      cal.each_day do |day|
        # the day of the month is day.number
        # do stuff with day.data
        if day.today?
          # omg, it's RIGHT NOW
        end
      end

## Configuration

By default the first day of the week is Sunday, however this can be changed to Monday like so:

      Calorie.configuration do |config|
        config.week_starts_on :monday
      end


You will need to add translations for your locale(s).
The translations for the week begin with Sunday, regardless of how you configure your week.


    # en.yml
    ---
    calorie:
      days_of_the_week: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
      months: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]



    # fr.yml
    ---
    calorie:
      days_of_the_week: ["di", "lu", "ma", "me", "je", "ve", "sa"]
      months: ["janv.", "fevr.", "mars", "avr.", "mai", "juin", "juil.", "aout", "sept.", "oct.", "nov.", "dec."]


## TODO

* day of the week labels need to be something that can respond to `weekend?`
* week number per ISO 8601

### week number rules:

If 1 January is on a Monday, Tuesday, Wednesday or Thursday, it is in week 01. If 1 January is on a Friday, Saturday or Sunday, it is in week 52 or 53 of the previous year (there is no week 00). 28 December is always in the last week of its year.

There are mutually equivalent descriptions of week 01:

* the week with the year's first Thursday in it (the formal ISO definition),
* the week with 4 January in it,
* the first week with the majority (four or more) of its days in the starting year, and
* the week starting with the Monday in the period 29 December – 4 January.

Her er noen eksempler [1]

4. januar 1993 er en mandag (1993-01-04)

    1993-01-03 → 1992-W53-7
    1993-01-04 → 1993-W01-1

4. januar 1998 er en søndag (1998-01-04)

    1997-12-28 → 1997-W52-7
    1997-12-29 → 1998-W01-1
    1998-01-04 → 1998-W01-7

År starter på en torsdag

    1998-01-01 → 1998-W01-4 (dvs. en torsdag)
    1998-12-31 → 1998-W53-4 (→skuddårsuke!)

År starter på en onsdag og er skuddår

    1992-01-01 → 1992-W01-3 (dvs. en onsdag)
    1992-02-29 → 1992-W09-6 (og skuddår)
    1992-12-31 → 1992-W53-4 (→skuddårsuke)

År starter på en onsdag og året er ikke skuddår

    1975-01-01 → 1975-W01-3 (dvs. en onsdag)
    1975-02-29 → eksisterer ikke
    1975-12-28 → 1975-W52-7
    1975-12-29 → 1976-W01-1 (ikke skuddår i 1975)

