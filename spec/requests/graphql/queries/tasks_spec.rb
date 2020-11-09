# frozen_string_literal: true

describe 'tasks query', type: :request do
  let!(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }

  let(:task_project) { create(:task_project, with_today_tasks: true, user_account: user_account) }

  before { task_project }

  context 'when user account' do
    context 'when without filter' do
      it 'returns all data' do
        authorized_graphql_post(
          query: tasks_guery,
          variables: {},
          auth_token: token
        )

        expect(response).to match_schema(UserTask::TasksSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when with sort' do
      it 'returns today data' do
        authorized_graphql_post(
          query: tasks_guery,
          variables: { input: { sort: 'CREATED_AT', direction: 'DESC' } },
          auth_token: token
        )

        expect(response).to match_schema(UserTask::TasksSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when with filter' do
      it 'returns today data' do
        authorized_graphql_post(
          query: tasks_guery,
          variables: { input: { filter: 'TODAY' } },
          auth_token: token
        )

        expect(response).to match_schema(UserTask::TasksSchema)
        expect(response.status).to be(200)
      end
    end
  end

  context 'when no account' do
    it 'returns authentication error data' do
      graphql_post(
        query: tasks_guery
      )

      expect(response).to match_schema(AuthenticationErrorSchema)
      expect(response.status).to be(200)
    end
  end
end
