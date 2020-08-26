# frozen_string_literal: true

describe 'mutation userAreaCreate', type: :request do
  let(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id )}
  let(:name) { FFaker::Lorem.word }
  let(:variables) { { input: { name: name, type: 'TASK_AREA' } } }

  context 'when success' do
    it 'returns created area of current_user' do
      authorized_graphql_post(
        query: user_area_create_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserArea::CreateSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange type' do
      let(:variables) { { input: { name: name, type: FFaker::Lorem.word } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_area_create_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      before { allow_any_instance_of(TaskArea).to receive(:save).and_raise(ActiveRecord::ActiveRecordError) }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_area_create_mutation,
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
          query: user_area_create_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
