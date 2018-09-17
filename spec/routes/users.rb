require_relative '../spec_helper'

describe UsersController do
  describe 'GET /' do
    before do
      FactoryBot.create(:user, name: 'Jonas')
      FactoryBot.create(:user, name: 'Jose')
    end

    it 'has a ok response code' do
      get '/'
      expect(last_response.status).to eq 200
    end

    it 'lists all the users' do
      get '/'
      json_response = JSON.parse(last_response.body, symbolize_names: true)
      expect(json_response.size).to eq(2)
      expect(json_response.map { |h| h[:name] }).to match_array(['Jonas', 'Jose'])
    end
  end

  describe 'POST /' do
    context 'when the params are valid' do
      let(:params) {{ user: { name: 'Lucas', age: 12, gender: 0, latitude: 15, longitude: 16 } }}

      it 'has a created response code' do
        post('/', params.to_json)
        expect(last_response.status).to eq 201
      end

      it 'creates the user' do
        expect { post('/', params.to_json) }
          .to change { User.count }.from(0).to(1)
      end

      it 'returns the serialized user' do
        post('/', params.to_json)
        json_response = JSON.parse(last_response.body, symbolize_names: true)
        expect(json_response).to include(
          id: a_kind_of(Integer),
          name: 'Lucas',
          age: 12,
          gender: 0,
          latitude: 15,
          longitude: 16
        )
      end
    end

    context 'when the params are not valid' do
      let(:params) {{ user: { nome: 'Lucas' } }}
      it 'does not create the user' do
        expect { post('/', params.to_json) }
          .not_to change { User.count }
      end
    end
  end

  describe 'PATCH /:id' do
    let(:user) { FactoryBot.create(:user, latitude: 1, longitude: 2) }

    context 'when the parameters are valid' do
      let(:params) {{ user: { latitude: 15, longitude: 16 } }}

      it 'has a ok response code' do
        patch("/#{user.id}", params.to_json)
        expect(last_response.status).to eq 200
      end

      it 'updates the users\' parameters' do 
        expect { patch("/#{user.id}", params.to_json) }
          .to change { user.reload.latitude }.from(1).to(15)
          .and change { user.reload.longitude }.from(2).to(16)
      end

      it 'returns the updated resource' do
        patch("/#{user.id}", params.to_json)
        json_response = JSON.parse(last_response.body, symbolize_names: true)
        expect(json_response).to include(
          id: user.id,
          latitude: 15,
          longitude: 16
        )
      end
    end

    context 'when the params are not valid' do
      let(:params) {{ usuario: { latitude: 99 } }}

      it 'has a unprocessable entity response code' do
        patch("/#{user.id}", params.to_json)
        expect(last_response.status).to eq 422
      end

      it 'does not change the user' do
        expect { patch("/#{user.id}", params.to_json) }
          .not_to change { user.reload.latitude }
      end
    end

    context 'when the supplied id does not match a existent user' do
      let(:params) {{ user: { latitude: 15 } }}

      it 'has a not found response code' do
        patch("/#{user.id + 1}", params.to_json)
        expect(last_response.status).to eq 404
      end
    end
  end
end
