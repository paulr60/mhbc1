# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  article    :text
#  date       :date
#  start_time :time
#  start_date :date
#  end_date   :date
#  sun        :boolean          default(TRUE)
#  mon        :boolean          default(TRUE)
#  tue        :boolean          default(TRUE)
#  wed        :boolean          default(TRUE)
#  thu        :boolean          default(TRUE)
#  fri        :boolean          default(TRUE)
#  sat        :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
