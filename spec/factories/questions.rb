# == Schema Information
#
# Table name: questions
#
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  question   :string           not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :question do
    question { "MyString" }
  end
end
