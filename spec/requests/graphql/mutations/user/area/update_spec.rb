# frozen_string_literal: true

describe 'mutation userAreaCreate', type: :request do
  let(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }
  let(:area) { create(:area, user_account: user_account) }
  let(:name) { FFaker::Lorem.word }

  let(:variables) { { input: { id: area.id, name: name } } }

  context 'when success' do
    it 'returns updated area of current_user' do
      authorized_graphql_post(
        query: user_area_update_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserArea::UpdateSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when area not found' do
      let(:variables) { { input: { id: SecureRandom.uuid, name: name } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_area_update_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ExecutionErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when area not belongs to current user' do
      let(:variables) { { input: { id: SecureRandom.uuid, name: name } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_area_update_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ExecutionErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      # rubocop:disable RSpec/AnyInstance
      before { allow_any_instance_of(TaskArea).to receive(:save).and_raise(ActiveRecord::ActiveRecordError) }
      # rubocop:enable RSpec/AnyInstance

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_area_update_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ExecutionErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when user not authorized' do
      it 'returns error' do
        graphql_post(
          query: user_area_update_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end