# == Schema Information
#
# Table name: galleries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  photos      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

require 'spec_helper'

describe Gallery do
  pending "add some examples to (or delete) #{__FILE__}"
end
