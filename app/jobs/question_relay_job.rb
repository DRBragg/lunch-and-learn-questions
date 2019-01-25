class QuestionRelayJob < ApplicationJob
  queue_as :default

  def perform(question)
    html = ApplicationController.render partial: 'questions/question', locals: { question: question }, formats: [:html]
    ActionCable.server.broadcast 'questions', html: html
  end
end
