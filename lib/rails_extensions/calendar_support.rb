module CalendarSupport

    class DateSet
        attr_reader :errs, :dates

        def initialize(date_string_list)    # [yyyy-mm-dd, yyyy-mm-dd, ...]
            @dates = parse(date_string_list)
        end

        def to_s
            date_strings = dates.collect { |d| d.strftime('%b %e') }
            date_strings.join(', ')
        end

        def on_or_after(start_date)
            filtered = @dates.clone
            filtered.delete_if { |d| d < start_date }
            return filtered
        end

        private
            def parse(date_list)
                return [] if date_list.blank?
                @errs = []
                dates = []
                toks = date_list.split(',')
                toks.each do |t|
                    d = Date.parse(t.strip)
                    @errs << t if d == nil
                    dates << d if d != nil
                end
                return dates
            end
    end

    class DateRange
        attr_reader :dates, :errs

        def initialize(from, to, days_of_week, cancelled_dates)
            @from = from    # 'Date' instance
            @to = to        # 'Date' instance
            @cancelled_dates = cancelled_dates
            @dates = []
            @from.upto(@to) do |d|
                if days_of_week[d.wday] && (@cancelled_dates.dates.index(d) == nil)
                    @dates << d
                end
            end
        end

        def to_s
            @from.to_s + ' to ' + @to.to_s
        end
    end

    class FilteredDateRange < DateRange
        def initialize(from, to, days_of_week, cancelled, window_start, window_end)
            if window_start && window_end
                start_date = (from > window_start) ? from : window_start
                end_date = (to < window_end) ? to : window_end
            else
                start_date = from
                end_date = to
            end
            super(start_date, end_date, days_of_week, cancelled)
        end
    end

    class EventDates
        def initialize(date, start_date, end_date, active, cancelled, window_start, window_end)
            @date_set = DateSet.new(date)
            if start_date.blank? == false
                @start_date_set = DateSet.new(start_date)
                @end_date_set = DateSet.new(end_date)
                @cancelled_date_set = DateSet.new(cancelled)
                @date_range = FilteredDateRange.new(@start_date_set.dates[0], @end_date_set.dates[0],
                                            active, @cancelled_date_set, window_start, window_end)
            end
        end
        def is_range?
            @date_range != nil
        end
        def date_list
            @date_range ? @date_range.dates : @date_set.dates
        end
        def dates_on_or_after(begin_date)
            filtered = date_list.clone
            filtered.delete_if { |d| d < begin_date }
            return filtered
        end
        def date_string
            if is_range? == false
                s = EventDates.prettyprint(@date_set.dates)
            else
                s = EventDates.prettyprint(@start_date_set.dates) + ' to ' +
                            EventDates.prettyprint(@end_date_set.dates)
            end
            return s
        end
        def EventDates.prettyprint(datelist)
            strings = datelist.collect { |d| d.strftime('%b %e') }
            return strings.join(', ')
        end
    end

    class Calendar
        attr_reader :year, :month

        def initialize(context, year, month, events)
            @context = context
            @year = year
            @month = month
            @events = events

            @last_day_cache = Date.new(@year, @month + 1, 1) - 1
            @first_day_cache = Date.new(@year, @month, 1)
        end

        def last_day
            @last_day_cache
        end

        def num_days_in_month
            last_day.mday
        end

        # Day of week of 1st day of this month (Sun = 0)
        def first_wday
            @first_day_cache.wday
        end

        # Day of week of last day of this month (Sun = 0)
        def last_wday
            last_day.wday
        end

        # 2-dimensional array of dates (incl. some from prior and/or next month)
        # that will fully fill table to be rendered.
        def dates_to_display
            rows = []
            day1 = @first_day_cache
            sunday = day1 - first_wday
            end_of_month = last_day
            while sunday <= end_of_month
                week = (0..6).collect { |n| sunday + n }
                rows << week
                sunday += 7
            end
            return rows
        end

        def html
            s = table_header_html
            s += table_body_html(dates_to_display)
            return s.html_safe
        end

        private

            def event_dates(window_start, window_end)
                ed_list = []
                @events.each do |e|
                    ed = EventDates.new(e.date, e.start_date, e.end_date,
                                                e.active_days, e.cancelled_dates,
                                                window_start, window_end)
                    ed_list << [e, ed]
                end
                return ed_list
            end

            def table_header_html
                days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday',
                        'Thursday', 'Friday', 'Saturday']
                s = "<thead><tr>\n"
                days.each do |d|
                    s += "\t<th>#{d}</th>\n"
                end
                s += "</tr></thead>"
                return s.html_safe
            end

            def table_body_html(dates)
                s = "<tbody>\n"
                window_start = dates[0][0]
                window_end = dates[-1][-1]
                ed_list = event_dates(window_start, window_end)
                dates.each do |date_row|
                    s += "\t<tr>\n"
                    date_row.each do |d|
                        event_links = ''
                        ed_list.each do |ed_elem|
                            if ed_elem[1].date_list.index(d)
                                event_links += event_html(ed_elem[0])
                            end
                        end
#                        @events.each do |e|
#                            ed = EventDates.new(e.date, e.start_date, e.end_date,
#                                                e.active_days, e.cancelled_dates)
#                            if ed.date_list.index(d)
#                                event_links += event_html(e)
#                            end
#                        end
                        cl = (d.mon == @month) ? 'this-month' : 'other-month'
                        s += "\t\t<td class=\"#{cl}\">"
                        s += "<div class='pull-right'>#{d.mday}</div>"
                        s += "#{event_links}</td>\n"
                    end
                    s += "\t</tr>\n"
                end
                s += "</tbody>\n"
                return s.html_safe
            end

            def event_html(e)
                text = e.start_time.blank? ? e.abbr : e.start_time + ' ' + e.abbr
                s = '<div class="pull-left">' + @context.link_to(text, e) +
                        '</div><br>'.html_safe
            end
    end
end
