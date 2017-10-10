require "telemetry"

RSpec.describe TelemetryDiagnostics do 
    describe "#check_transmission"  do
         context "with failing online status" do
             it "throws an error" do
                tc = instance_double("TelemetryClient", :online_status => false)
                allow(TelemetryClient).to receive(:new) {tc}
                td = TelemetryDiagnostics.new 
                
                expect{td.check_transmission}.to raise_exception.with_message("Unable to connect.")
              end
         end

        #  context "with passing online status" do
        #     it "returns diagnostic info" do
        #        td = TelemetryDiagnostics.new 
        #        tc_2 = TelemetryClient.new
        #        allow(TelemetryClient).to receive(:new) {tc_2}
        #        allow(tc_2).to receive(:online_status) {true}
        #        expect(td.check_transmission).to eq('hi')
        #      end
        # end
    end

end