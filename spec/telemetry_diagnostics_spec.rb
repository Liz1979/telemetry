require "telemetry"

RSpec.describe TelemetryDiagnostics do 
    describe "#check_transmission"  do
       before do
         allow(TelemetryClient).to receive(:new) {tc}
        end       
         context "with failing online status" do
            let(:tc) { instance_double("TelemetryClient", 
            :online_status => false,
            :connect => nil,
            :disconnect => nil
          ) }
             it "throws an error" do
                td = TelemetryDiagnostics.new(tc) 
                
                expect { td.check_transmission }.to raise_exception.with_message("Unable to connect.")
              end
         end

         context "with passing online status" do
            let(:tc) {instance_double(
                "TelemetryClient", 
                :online_status => true,
                :connect => nil,
                :disconnect => nil,
                :send => "sent",
                :receive => "receive",
            )}
            it "returns diagnostic info" do
              td = TelemetryDiagnostics.new(tc)

               expect(td.check_transmission).to eq('receive')
             end


        end
    end

end