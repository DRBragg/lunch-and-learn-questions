# == Schema Information
#
# Table name: questions
#
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  question   :string           not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  default_scope -> { order('created_at DESC') }
  after_commit :broadcast_question

  validates_presence_of :question

  def broadcast_question
    html = ApplicationController.render partial: 'questions/question', locals: { question: self }, formats: [:html]
    ActionCable.server.broadcast 'questions', html: html
  end

  def display_for_slack
    {
      fallback: question,
      color: '#36a64f',
      title: "Question ##{id}",
      title_link: 'https://landl.cellohealthdigital.com/questions/5',
      text: question,
      footer: 'Digital Lunch & Learn',
      footer_icon: 'https://landl.cellohealthdigital.com/images/icons/icon-72x72.png',
      ts: created_at.to_i
    }
  end
end
