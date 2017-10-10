require "telemetry"

RSpec.describe TelemetryDiagnostics do 
    describe "#check_transmission"  do
         context "with failing online status" do
             it "throws an error" do
                tc = instance_double("TelemetryClient", 
                  :online_status => false,
                  :connect => nil,
                  :disconnect => nil
                )
                allow(TelemetryClient).to receive(:new) {tc}
                td = TelemetryDiagnostics.new 
                
                expect { td.check_transmission }.to raise_exception.with_message("Unable to connect.")
              end
         end

         context "with passing online status" do
            it "returns diagnostic info" do
                tc = instance_double(
                    "TelemetryClient", 
                    :online_status => true,
                    :connect => nil,
                    :disconnect => nil,
                    :send => "sent",
                    :receive => "receive",
                )
              allow(TelemetryClient).to receive(:new) {tc}
              td = TelemetryDiagnostics.new 

               expect(td.check_transmission).to eq('receive')
             end
        end
    end

end