# frozen_string_literal: true

describe 'mutation moveProjectWithinTask', type: :request do
  let_it_be(:current_user) { create(:user_account) }

  let(:area) { create(:task_area, with_projects: true, project_count: 3, user_account: current_user) }
  let(:another_area) { create(:task_area, with_projects: true, user_account: current_user) }
  let(:second_project) { area.task_projects.find_by(position: 2) }

  let(:token) { generate_token(account_id: current_user.id) }

  let(:variables) { { input: { id: second_project.id, area_id: another_area.id } } }

  context 'when success' do
    it 'returns success result' do
      authorized_graphql_post(
        query: move_project_within_area_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(Move::Project::WithinArea)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange id' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: move_project_within_area_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      # rubocop:disable RSpec/AnyInstance
      before { allow_any_instance_of(TaskProject).to receive(:update!).and_raise(ActiveRecord::ActiveRecordError) }
      # rubocop:enable RSpec/AnyInstance

      it 'returns execution error data' do
        authorized_graphql_post(
          query: move_project_within_area_mutation,
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
          query: move_project_within_area_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
