RSpec.describe 'POST /events', type: :request do
  describe 'POST /events' do

    before do
      post '/events',
        params: {
          event: {
            title: 'I Just Created This',
            description: 'I dont want anyone to join this event',
            category: 'casual'
          }
        }
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
      post '/events',
      params: {
        event: {
          title: '',
          description: 'I dont want anyone to join this event',
          category: 'casual'
        }
      }
    end

    it 'event is missing an attribute' do
      expect(response.status).to eq 422
    end

    it 'displays error message' do
      expect(JSON.parse(response.body)['message']).to eq 'Event was NOT created.'
    end
  end
end
