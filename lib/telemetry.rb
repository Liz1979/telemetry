require 'client'

class TelemetryDiagnostics
  attr_accessor :diagnostic_info
  attr_reader :telemetry_client
  DIAGNOSTIC_CHANNEL_CONNECTION_STRING = "*111#"
  
  def initialize(telemetry_client)
    @telemetry_client = telemetry_client
    @diagnostic_info = ""
  end

  def check_transmission
    telemetry_client.disconnect

    attempt_to_make_connection
    validate_online

    telemetry_client.send(TelemetryClient::DIAGNOSTIC_MESSAGE)
    self.diagnostic_info = telemetry_client.receive
  end

  private

  def online?
    !!telemetry_client.online_status  
  end

  def validate_online
    unless online?
      raise Exception.new("Unable to connect.")
    end
  end

  def attempt_to_make_connection(n = 3)
    n.times do 
      telemetry_client.connect(DIAGNOSTIC_CHANNEL_CONNECTION_STRING)
      break if online?
     end
   end 
end
