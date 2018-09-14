require_relative '../spec_helper'

describe UsersController do
  describe 'GET /' do
    it 'lists all the users' do
      User.create(name: 'Jonas')
      User.create(name: 'Jose')

      get '/'
      json_response = JSON.parse(last_response.body, symbolize_names: true)
      expect(json_response.size).to eq(2)
      expect(json_response.map { |h| h[:name] }).to match_array(['Jonas', 'Jose'])
    end
  end

  describe 'POST /' do
    context 'when the params are valid' do
      let(:params) {{ user: { name: 'Lucas' } }}
      it 'creates the user' do
        expect { post('/', params.to_json) }
          .to change { User.count }.from(0).to(1)
      end

      it 'returns the serialized user' do
        post('/', params.to_json)
        json_response = JSON.parse(last_response.body, symbolize_names: true)
        expect(json_response).to include({ id: a_kind_of(Integer), name: 'Lucas' })
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
end
