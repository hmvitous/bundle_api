RSpec.describe 'GET /events', type: :request do
  describe 'GET /events' do
    let!(:event) { create(
      :event,
        title: 'Celebrate easter with me!',
        description: 'Kevin is not allowed to come. Complete buzzkill',
        category: 'casual'
      )}

    before do
      get '/events'
    end
    
    it 'should return a 200 response' do 
      expect(response.status).to eq 200
    end
    
    it 'finds correct event title' do
      expect(event.title).to eq 'Celebrate easter with me!'
    end

    it 'finds correct event description' do
      expect(event.description).to eq 'Kevin is not allowed to come. Complete buzzkill'
    end
    it 'finds correct event category' do
      expect(event.category).to eq 'casual'
    end
    
  end
  
  describe 'GET, when there are no events' do
    before do
      get '/events'
    end

    it 'has no events' do
      expect(response.status).to eq 404
    end

    it 'displays error message' do
      expect(JSON.parse(response.body)['message']).to eq 'No events present'
    end
  end
end
