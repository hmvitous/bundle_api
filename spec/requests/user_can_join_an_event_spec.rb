RSpec.describe 'PUT /events', type: :request do
  let(:event_creator) { create(:user) }
  let(:event) { create(:event, user: event_creator)}
  let!(:other_attendees) { 4.times { create(:attendee, event: event) } }
  let(:attendee) { create(:user, email: 'attendee@mail.com') }
  let(:user_credentials) { attendee.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: "application/json" }.merge!(user_credentials) }
  
  describe 'User can attend event successfully' do
    before do
      put "/api/events/#{event.id}", headers: user_headers
    end
    it 'returns 200 response' do 
      expect(response.status).to eq 200
    end
    it 'returns success message' do 
      expect(response_json['message']).to eq 'You are on the guest list!'
    end
  end
end 