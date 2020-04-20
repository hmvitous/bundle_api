RSpec.describe 'POST /events', type: :request do
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: "application/json" }.merge!(user_credentials) }
  
  let(:visitor) { create(:user, authenticated: false)}
  let(:visitor_headers) {{ HTTP_ACCEPT: "application/json" }
}
  describe 'POST /api/events' do
    before do
      post '/api/events',
      params: {
        event: {
          title: 'I Just Created This',
          description: 'I dont want anyone to join this event',
          category: 'casual',
          user_id: user.id,
          attendee_limit: 4
        }
      },
      headers: user_headers
    end
    
    it 'should return a 200 response' do 
      expect(response.status).to eq 200
    end

    it 'displays success message' do
      expect(JSON.parse(response.body)['message']).to eq 'Event was successfully created!'
    end
  end
  
  describe 'Sad Path, Event can not be created' do
    before do
      post '/api/events',
      params: {
        event: {
          title: '',
          description: 'I dont want anyone to join this event',
          category: 'casual'
        }
      },
      headers: user_headers
    end

    it 'event is missing an attribute' do
      expect(response.status).to eq 422
    end

    it 'displays error message' do
      expect(JSON.parse(response.body)['message']).to eq 'Event was NOT created.'
    end
  end

  describe 'Un-authenticated user tries to create an event' do
    before do
      post '/api/events',
      params: {
        event: {
          title: 'Im not allowed to make this',
          description: 'It shouldnt exist',
          category: 'games',
          user_id: '',
          attendee_limit: 4
        }      
      },
      headers: visitor_headers
    end
    
    it 'returns a 401 response status' do
      expect(response.status).to eq 401
    end

    it 'returns not authorize message ' do
      expect(response_json['message']).to eq 'You need to login before creating an event.'
    end
  end

end
