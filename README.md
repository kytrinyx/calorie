# Calorie

A calendar is a calendar is a calendar.

Motivated by the frustration of solving the same problem in a dozen different ugly ways in a dozen different applications.

## Requirements

This uses the ruby core `Date` library.

In other words, rails is *not* required.

## Usage

Create a hash that uses the day of the month as the key.
The data can be anything, and only your code will be interacting with it.

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

In your view, you can style it however you wish, e.g.:

      cal.days_of_the_week do |label|
        if day.weekend?
          # label styled as a weekend
        else
          # label styled as a weekday
        end
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


If you don't need to lay it out by week, you can also iterate straight through the days:

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

## TODO

* i18n for days of the week
* add labels for current, previous, and next month (with i18n support)
