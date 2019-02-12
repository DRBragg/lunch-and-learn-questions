# require 'pry'
require 'httparty'

class Bot < SlackRubyBot::Bot
  @id = 0
  APP_URLS = {
    'vap demo api' => 'https://vap-demo.cellohealthdigital.com/version',
    'ovap api' => 'https://vap-api.cellohealthdigital.com/version',
    'evap api' => 'https://api.paciraevap.com/version',
    'vap demo' => 'https://vap.cellohealthdigital.com/',
    'ovap' => 'https://ovap.cellohealthdigital.com/',
    'evap' => 'https://paciraevap.com/'
  }

  def self.next_id
    @id = @id % 10 + 1
  end

  command 'say' do |client, data, match|
    Rails.cache.write next_id, { text: match['expression'] }
    client.say(channel: data.channel, text: match['expression'])
  end

  command 'ping' do |client, data, match|
    url = APP_URLS[match['expression'].downcase]
    if url.present?
      app_status = match['expression'].downcase.include?('api') ? ping_api(url) : ping_client(url)
      client.say(channel: data.channel, text: "#{match['expression']} is #{app_status}")
    else
      client.say(channel: data.channel, text: "Sorry, #{match['expression']} doesn't match any applications I have on record")
    end
  end

  def self.ping_api(url)
    response = HTTParty.get(url)
    app_data = response.parsed_response
    response.code == 200 ? "running #{app_data['version']}" : 'Down'
  end

  def self.ping_client(url)
    response = HTTParty.get(url)
    response.code == 200 ? 'Ok' : 'Down'
  end
end
