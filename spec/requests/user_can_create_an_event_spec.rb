RSpec.describe 'POST /events', type: :request do
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: "application/json" }.merge!(user_credentials) }
  describe 'POST /events' do

    before do
      post '/api/events',
      params: {
        event: {
          title: 'I Just Created This',
          description: 'I dont want anyone to join this event',
          category: 'casual'
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
end
