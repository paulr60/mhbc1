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

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
