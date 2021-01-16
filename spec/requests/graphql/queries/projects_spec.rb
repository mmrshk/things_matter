# frozen_string_literal: true

describe 'tasks query', type: :request do
  let!(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }

  let(:task_project) { create(:task_project, user_account: user_account) }
  let(:deleted_tasks) { create_list(:task, 3, task_project: task_project, deleted: true) }
  let(:tasks) { create_list(:task, 3, task_project: task_project, deleted: true, with_task_tag: true) }

  before do
    deleted_tasks
    tasks
  end

  context 'when user account' do
    context 'when without filter' do
      it 'returns all data' do
        authorized_graphql_post(
          query: projects_guery,
          variables: {},
          auth_token: token
        )

        expect(response).to match_schema(UserTaskProject::ProjectsSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when with filter' do
      it 'returns deleted projects data' do
        authorized_graphql_post(
          query: projects_guery,
          variables: { filter: 'trash', id: task_project.id },
          auth_token: token
        )

        expect(response).to match_schema(UserTaskProject::ProjectsSchema)
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
