# frozen_string_literal: true

describe 'mutation userTaskRecover', type: :request do
  let(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }

  let(:variables) { { input: { id: task.id } } }

  let(:task) { create(:task, user_account: user_account) }

  context 'when success' do
    context 'when exist project' do
      it 'returns updated task of current_user' do
        authorized_graphql_post(
          query: user_task_recover_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(UserTask::RecoverSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when project NOT exist' do
      let(:task) { create(:task, user_account: user_account, without_task_project: true) }
      let(:variables) { { input: { id: task.id, task_location: 'TODAY' } } }

      it 'returns updated task of current_user' do
        authorized_graphql_post(
          query: user_task_recover_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(UserTask::RecoverSchema)
        expect(response.status).to be(200)
      end
    end
  end

  context 'when failed' do
    context 'when task not found' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_task_recover_mutation,
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
          query: user_task_recover_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
