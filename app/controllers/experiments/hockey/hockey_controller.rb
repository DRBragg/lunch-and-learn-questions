require 'openssl'
require 'active_support/security_utils'
require 'nokogiri'
require 'open-uri'

class Experiments::Hockey::HockeyController < ApplicationController
  skip_before_action :verify_authenticity_token
  #before_action :verify_slack_request

  def create
    if params[:text]
      attachments = scrape_by_input(params[:text])
    else
      attachments = scrape_bucks
      attachments.concat(scrap_hatfield)
    end
    render json: {text: "Upcoming Sticks and Pucks", attachments: attachments}
  end

  private

    def verify_slack_request
      timestamp = request.headers['X-Slack-Request-Timestamp']
      if (Time.now.to_i - timestamp.to_i).abs > 60 * 5
        head :unauthorized
        return
      end

      sig_basestring  = "v0:#{timestamp}:#{request.raw_post}"
      signature       = "v0=" + OpenSSL::HMAC.hexdigest("SHA256", Rails.application.credentials.dig(:experiments, :hockey, :slack_signing_secret), sig_basestring)
      slack_signature = request.headers['X-Slack-Signature']

      if !ActiveSupport::SecurityUtils.secure_compare(signature, slack_signature)
        head :unauthorized
      end
    end

    def scrape_by_input(input)
      rink = input&.split(" ")&.first&.downcase
      if rink === "bucks"
        scrape_bucks.first
      elsif rink === "wintersports"
        scrape_bucks.last
      elsif rink === "hatfield"
        scrap_hatfield
      else
        attachments = scrape_bucks
        attachments.concat(scrap_hatfield)
      end
    end

    def scrap_hatfield
      site = Nokogiri::HTML(open("http://hatfieldice.maxgalaxy.net/Schedule.aspx?ID=6"))
      data = site.css(".rsAptColor").map{|x| x.attributes["title"].value}
      html_data = data.map { |e| Nokogiri::HTML(e) }
      dates = html_data.map do |data|
        "#{data.css(".wrToolTipValue")[1].text} - #{data.css(".wrToolTipTime").text} #{data.css(".wrToolTipValue").first.text}"
      end
      [
        make_slack_attachment("Hatfield Ice", "350 County Line Road Colmar PA", dates.join("\n"))
      ]
    end

    def scrape_bucks
      site = Nokogiri::HTML(open("http://bucksice.com/daily-schedules/stick-pucks/"))
      data = site.css(".entry-content p").map(&:text).join(",").split("_______________________________")
      bucks = data.first.split(",")
      wintersports = data.last.split(",")
      [
        convert_s_and_p(bucks - [""]),
        convert_s_and_p(wintersports - [""])
      ]
    end

    def convert_s_and_p(data)
      name = data.shift
      loc = data.shift
      dates = data.join("\n")
      make_slack_attachment(name, loc, dates)
    end

    def make_slack_attachment(name, loc, dates)
      {
        fallback: dates,
        color: "#36a64f",
        title: name,
        text: loc,
        fields: [
          {
            title: "Dates",
            value: dates,
            short: false}
        ],
        footer: "Hockey Scraper",
        footer_icon: "http://bucksice.com/wp-content/themes/epik/images/favicon.ico",
        ts: DateTime.now.to_i
      }
    end
end
