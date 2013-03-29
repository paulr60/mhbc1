module CalendarSupport
    class Calendar
        def initialize(year, month)
            @year = year
            @month = month
        end

        def last_day
            Date.new(@year, @month + 1, 1) - 1
        end

        def num_days_in_month
            last_day.mday
        end

        # Day of week of 1st day of this month (Sun = 0)
        def first_wday
            d = Date.new(@year, @month, 1)
            d.wday
        end

        # Day of week of last day of this month (Sun = 0)
        def last_wday
            last_day.wday
        end

        # 2-dimensional array of dates (incl. some from prior and/or next month)
        # that will fully fill table to be rendered.
        def dates_to_display
            rows = []
            day1 = Date.new(@year, @month, 1)
            next_day = day1 - first_wday
            end_of_month = last_day
            while next_day <= end_of_month
                week = []
                7.times do
                    week << next_day
                    next_day += 1
                end
                rows << week
            end
            return rows
        end

    end
end
