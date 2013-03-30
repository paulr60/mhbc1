# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  article         :text
#  date            :string(255)
#  start_time      :string(255)
#  start_date      :string(255)
#  end_date        :string(255)
#  sun             :boolean          default(FALSE)
#  mon             :boolean          default(FALSE)
#  tue             :boolean          default(FALSE)
#  wed             :boolean          default(FALSE)
#  thu             :boolean          default(FALSE)
#  fri             :boolean          default(FALSE)
#  sat             :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cancelled_dates :text
#  abbr            :string(255)
#

class Event < ActiveRecord::Base
    attr_accessible :name, :abbr, :article, :date, :start_time,
            :start_date, :end_date, :cancelled_dates,
            :sun, :mon, :tue, :wed, :thu, :fri, :sat

	validates :name, presence: true

    validate :valid_args

    def recurring?
        start_date.present?
    end

    def active_days
        day_fields = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat']
        active = day_fields.collect { |f| eval(f) }
    end

    def cancelled_date_list
        dates = cancelled_dates.split(',')
        cancelled = dates.collect { |d| Calendar.date_parse(d) }
    end

    def date_list
        return [Calendar.date_parse(date)] if start_date.blank?
        dates = []
        active = active_days
        (Calendar.date_parse(start_date)).upto(Calendar.date_parse(end_date)) do |d|
            if active[d.wday] && (cancelled_date_list.index(d) == nil)
                dates << d
            end
        end
        return dates
    end

    def date_list_starting_now
        today = Date.today
        all_dates = date_list
        all_dates.delete_if { |d| d < today }
    end

    def date_string
        s = start_date.blank? ? date : start_date + ' to ' + end_date
    end

    def valid_args
        if ((start_date.blank? && !end_date.blank?) ||
            (!start_date.blank? && end_date.blank?))
            errors.add :start_date, "Must enter both Start & End date or neither"
        end
        if start_date.blank? && date.blank?
            errors.add :date, "Must enter either Date or StartDate & EndDate"
        end
        if !date.blank? && !Calendar.date_parse(date)
            errors.add :date, "Illegal date format (yyyy-mm-dd)"
        end
        if !start_date.blank? && !Calendar.date_parse(start_date)
            errors.add :start_date, "Illegal date format (yyyy-mm-dd)"
        end        
        if !end_date.blank? && !Calendar.date_parse(end_date)
            errors.add :end_date, "Illegal date format (yyyy-mm-dd)"
        end
        if !cancelled_dates.blank?
            dates = cancelled_dates.split(',')
            dates.each do |d|
                if !Calendar.date_parse(d)
                    errors.add :cancelled_dates, "Illegal date format (#{d})"
                end
            end
        end
    end

end
