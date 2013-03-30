module CalendarSupport
    class Calendar
        attr_reader :year, :month

        def initialize(context, year, month, events)
            @context = context
            @year = year
            @month = month
            @events = events
        end

        def Calendar.date_parse(date_string)
            s = date_string.gsub('/','-')   # Allow either yyyy-mm-dd or yyyy/mm/dd
            toks = s.split('-')
            return nil if toks.length != 3
            d = Date.new(toks[0].to_i, toks[1].to_i, toks[2].to_i)
            return d
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

        def html
            table_html(dates_to_display)
        end

        private

            def table_html(dates)
                s = table_header_html
                s += table_body_html(dates)
                return s.html_safe
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
                dates.each do |date_row|
                    s += "\t<tr>\n"
                    date_row.each do |d|
                        event_links = ''
                        @events.each do |e|
                            if e.date_list.index(d)
                                event_links += event_html(e)
                            end
                        end
                        cl = (d.mon == @month) ? 'this-month' : 'other-month'
                        s += "\t\t<td class=\"#{cl}\">#{d.mday}#{event_links}</td>\n"
                    end
                    s += "\t</tr>\n"
                end
                s += "</tbody>\n"
                return s.html_safe
            end

            def event_html(e)
                text = e.start_time.blank? ? e.abbr : e.start_time + ' ' + e.abbr
                s = '<div class="pull-right">' + @context.link_to(text, e) +
                        '</div><br>'.html_safe
            end
    end
end
