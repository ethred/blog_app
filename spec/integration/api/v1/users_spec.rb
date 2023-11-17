require 'swagger_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  path '/api/v1/users' do
    get 'Retrieves a list of users' do
      produces 'application/json'

      response '200', 'users found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string }
                   # add other properties as needed
                 }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end
    end

    # add other test cases for 'create', 'show', 'update', 'destroy', etc.
  end
end
