# frozen_string_literal: true

describe 'mutation userTaskTagDelete', type: :request do
  let(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }
  let(:task) { create(:task, user_account: user_account) }
  let(:task_tag) { create(:task_tag, task: task) }

  let(:variables) { { input: { id: task_tag.id } } }

  context 'when success' do
    it 'returns updated task tag of current_user' do
      authorized_graphql_post(
        query: user_task_tag_delete_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserTaskTag::DeleteSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when task tag not found' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_task_tag_delete_mutation,
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
          query: user_task_tag_delete_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
