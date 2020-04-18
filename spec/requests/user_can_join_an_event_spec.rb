RSpec.describe 'PUT /api/events/:id', type: :request do
  let(:event_creator) { create(:user) }
  let(:event) { create(:event, attendee_limit: 20, user: event_creator)}

  let(:attendee) { create(:user, email: 'attendee@mail.com') }
  let(:user_credentials) { attendee.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: "application/json" }.merge!(user_credentials) }

  describe 'User can attend event successfully' do
    before do
      put "/api/events/#{event.id}", headers: user_headers
    end

    it 'returns 200 response status' do 
      expect(response.status).to eq 200
    end

    it 'returns success message' do 
      expect(response_json['message']).to eq 'You are on the guest list!'
    end
  end

  describe 'unsuccessfull when' do
    describe 'user is not authenticated' do
      before do
        put "/api/events/#{event.id}"
      end

      it 'returns 401 response status' do
        expect(response.status).to eq 401
      end

      it 'returns error message' do 
        expect(response_json['errors'].first).to eq "You need to sign in or sign up before continuing."
      end
    end
    
    describe 'event attendee limit is reached' do
      let!(:other_attendees) { 20.times { create(:attendee, event: event) } }

      before do 
        put "/api/events/#{event.id}", headers: user_headers
      end

      it 'returns 400 response status' do
        expect(response.status).to eq 400
      end

      it 'returns error message' do 
        expect(response_json['error_message']).to eq "Guest list is full..."
      end
    end

    describe 'event attendee limit is reached' do
      before do 
        put "/api/events/99", headers: user_headers
      end

      it 'returns 400 response status' do
        expect(response.status).to eq 400
      end

      it 'returns error message' do 
        expect(response_json['error_message']).to eq "We are experiencing internal errors. Please refresh the page and contact support. Couldn't find Event with 'id'={:id=>\"99\"}"
      end
    end
  end
end