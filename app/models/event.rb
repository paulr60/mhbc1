# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  article         :text
#  date            :text(255)
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


    def active_days
        day_fields = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat']
        active = day_fields.collect { |f| eval(f) }
    end

    def date_string
        if start_date.blank? == false
            prettyprint(start_date) + ' to ' + prettyprint(end_date)
        else
            toks = date.split(',')
            prettyprint(toks[0].strip) + (toks.length > 1 ? '...' : '')
        end
    end

    def prettyprint(canonical_date_string)
        d = Date.parse(canonical_date_string)
        d.strftime('%b %e')
    end
    

    def valid_args
        if ((start_date.blank? && !end_date.blank?) ||
            (!start_date.blank? && end_date.blank?))
            errors.add :start_date, "Must enter both Start & End date or neither"
        end
        if start_date.blank? && date.blank?
            errors.add :date, "Must enter either Date or StartDate & EndDate"
        end
        if !date.blank?
            ds = DateSet.new(date)
            ds.errs.each do |e|     # This array may be empty (if no errors)
                errors.add :date, "Illegal date format (#{e})"
            end
        end
        if !start_date.blank? && !Date.parse(start_date)
            errors.add :start_date, "Illegal date format (yyyy-mm-dd)"
        end        
        if !end_date.blank? && !Date.parse(end_date)
            errors.add :end_date, "Illegal date format (yyyy-mm-dd)"
        end
        if !cancelled_dates.blank?
            ds = DateSet.new(cancelled_dates)
            ds.errs.each do |e|     # This array may be empty (if no errors)
                errors.add :cancelled_dates, "Illegal date format (#{e})"
            end
        end
    end

end
