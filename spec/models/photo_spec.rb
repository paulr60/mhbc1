# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  image       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  custom_size :string(255)
#

require 'spec_helper'

describe Photo do
  pending "add some examples to (or delete) #{__FILE__}"
end
