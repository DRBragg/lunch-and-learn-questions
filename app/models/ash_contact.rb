# == Schema Information
#
# Table name: ash_contacts
#
#  created_at :datetime         not null
#  email      :string
#  id         :bigint(8)        not null, primary key
#  trial      :string
#  updated_at :datetime         not null
#

class AshContact < ApplicationRecord
end
