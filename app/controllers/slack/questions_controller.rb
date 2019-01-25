require 'openssl'
require 'active_support/security_utils'

class Slack::QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_slack_request

  def create
    questions = Question.all.limit(5)
    @questions = questions.to_a.map(&:display_for_slack)
    render json: { text: "Here's the last 5 questions", attachments: @questions }
  end

  private

  def verify_slack_request
    timestamp = request.headers['X-Slack-Request-Timestamp']
    if (Time.now.to_i - timestamp.to_i).abs > 60 * 5
      head :unauthorized
      return
    end

    sig_basestring  = "v0:#{timestamp}:#{request.raw_post}"
    signature       = 'v0=' + OpenSSL::HMAC.hexdigest('SHA256', Rails.application.credentials.slack_signing_secret, sig_basestring)
    slack_signature = request.headers['X-Slack-Signature']

    unless ActiveSupport::SecurityUtils.secure_compare(signature, slack_signature)
      head :unauthorized
    end
  end
end
