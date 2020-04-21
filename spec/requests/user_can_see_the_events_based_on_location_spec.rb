RSpec.describe Api::SessionsController, type: :request do

    describe "POST api/sessions" do
        it 'returns a "session" object with location and edition name for Gothenburg' do
            post "/api/sessions", params: {location: {latitude: 57.70, longitude: 11.97 } }
            expect(response_json['session']['edition']).to eq 'Gothenburg'
        end

        it 'returns a "session" object with location and edition name for Stockholm' do
            post "/api/sessions", params: {location: {latitude: 59.32 , longitude: 18.06 } }
            expect(response_json['session']['edition']).to eq 'Stockholm'
        end

        it 'returns a "session" object with location and edition name for a village' do
            post "/api/sessions", params: {location: {latitude: 57.82 , longitude: 12.27 } }
            expect(response_json['session']['edition']).to eq 'Country Wide'
        end
    end
end    