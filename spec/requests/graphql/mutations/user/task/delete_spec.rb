# frozen_string_literal: true

describe 'mutation userTaskDelete', type: :request do
  let(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }
  let(:project) { create(:task_project, user_account: user_account) }
  let(:task) { create(:task, task_project: project) }

  let(:variables) { { input: { id: task.id } } }

  context 'when success' do
    it 'returns competed status' do
      authorized_graphql_post(
        query: user_task_delete_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserTask::DeleteSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when task not found' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_task_delete_mutation,
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
          query: user_task_delete_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
