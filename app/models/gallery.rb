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

class Gallery < ActiveRecord::Base
  attr_accessible :name, :description, :photos
end
