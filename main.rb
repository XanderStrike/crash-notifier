#!/usr/local/bin/ruby
# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

class CrashChecker
  URL = 'https://crashspacela.com/sign/?output=json'
  FILENAME = 'previous.json'

  def self.run
    new.check
  end

  def initialize
    query_sign
  end

  def check
    if @body['is_open'] && !was_open_last_time?
      log "It's opened!"
      notify
    else
      log "Closed or state hasn't changed."
    end

    File.write(FILENAME, @body.to_json)
    log 'Done.'
  end

  def query_sign
    log 'Checking crashspace status...'
    uri = URI(URL)
    res = Net::HTTP.get_response(uri)
    raise unless res.is_a?(Net::HTTPSuccess)

    @body = JSON.parse(res.body)
  end

  def was_open_last_time?
    JSON.parse(File.read(FILENAME))['is_open']
  rescue StandardError => e
    log "Couldn't read previous file #{e}"
    false
  end

  def notify
    uri = URI(ENV["DISCORD_URL"])
    params = {
      content: "Someone hit the button at #{button_press_time}!",
      username: 'crashspace',
      avatar_url: 'https://crashspacela.com/sign/crashlogo-small.png'
    }
    Net::HTTP.post_form(uri, params)
  end

  def button_press_time
    @body['button_presses'].first['date']
  end

  def log(msg)
    puts "[#{Time.now}] #{msg}"
  end
end

CrashChecker.run if __FILE__== $PROGRAM_NAME
