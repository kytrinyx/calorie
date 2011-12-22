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

Obviously, you don't need to pass in any data -- if it's easy enough to just loop through and check what day it is and do whatever you need to do in your template, that's up to you.

Create a decorator for a month by sending in `year`, `month`, and the data:

      cal = Calorie.new(2010, 6, data)

In your template, you can style it however you wish.

      # previous month, e.g. December 2009
      cal.previous

      # current month, e.g. January 2010
      cal.current

      # next month, e.g. February 2010
      cal.next

      cal.days_of_the_week do |day|
        # day.label
        # day.weekend?
      end

      cal.weeks.each do |week|
        # week.number
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

Note: Weeks are numbered per ISO-8601. This gets a bit weird if you've configured your week to start on Sunday, as the ISO-8601 specifies that the week starts on Monday.
On the other hand, the definition for *week 1* is the week that has the year's first Thursday in it, so that can be defined unambiguously even if you start your week on a Sunday.

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
