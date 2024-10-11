require "kemal"
require "twilio"

# configure twilio client
Twilio.configure do |config|
  config.username = ENV["TWILIO_ACCOUNT_SID"]
  config.password = ENV["TWILIO_AUTH_TOKEN"]
end

# generate a sequence of random numbers
def random_numbers(length = 10)
  (1..length).map { rand(0..9).to_s }.join(" ")
end

# handle incoming calls
post "/twilio/voice" do |env|
  numbers = random_numbers(20) # change the number length if needed
  twiml = <<-TWIML
    <Response>
      <Say voice="alice" loop="2">#{numbers}</Say>
    </Response>
  TWIML

  env.response.content_type = "text/xml"
  env.response.print twiml
end

Kemal.run
