RSpec.describe Api::SessionsController, type: :request do

    describe "POST api/sessions" do
        it 'returns a "session" object with location and edition name for Gothenburg' do
            post "/api/sessions", params: {location: {latitude: 57.82, longitude: 12.27 } }
            expect(response_json['session']['edition']).to eq 'Gothenburg'
        end
    end
end    