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
  default_scope -> { order("created_at DESC") }
  after_commit :broadcast_question

  validates_presence_of :question

  def broadcast_question
    html = ApplicationController.render partial: "questions/question", locals: {question: self}, formats: [:html]
    ActionCable.server.broadcast "questions", html: html
  end
end
