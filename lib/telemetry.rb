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

    3.times do 
      telemetry_client.connect(DIAGNOSTIC_CHANNEL_CONNECTION_STRING)
      break if online?
    end

    unless online?
      raise Exception.new("Unable to connect.")
    end

    telemetry_client.send(TelemetryClient::DIAGNOSTIC_MESSAGE)
    self.diagnostic_info = telemetry_client.receive
  end

  private

  def online?
    !!telemetry_client.online_status  
  end
end
