RSpec.describe 'GET /api/events', type: :request do
  describe 'GET /api/events' do
    let!(:event_1) { create(:event, title: "Join me") }
    let!(:event_2) { create(:event, title: "Come play soccer") }
    let!(:event_3) { create(:event, title: "Lets go hiking") }

    before do
      get '/api/events'
    end

    it 'should return a 200 response' do 
      expect(response.status).to eq 200
    end
  end

  describe 'GET, No events been found' do
    before do
      get '/api/events'
    end

    it 'No events been found' do
      expect(response.status).to eq 404
    end
  end
end
