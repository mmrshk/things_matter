# frozen_string_literal: true

describe 'mutation moveProjectInTask', type: :request do
  let_it_be(:user_account) { create(:user_account) }

  let(:area) { create(:task_area, with_projects: true, project_count: 4, user_account: user_account) }

  let(:first_project) { area.task_projects.find_by(position: 1) }
  let(:second_project) { area.task_projects.find_by(position: 2) }
  let(:third_project) { area.task_projects.find_by(position: 3) }
  let(:fourth_project) { area.task_projects.find_by(position: 4) }

  let(:token) { generate_token(account_id: user_account.id) }

  let(:variables) do
    {
      input: {
        id: first_project.id,
        position: 1
      }
    }
  end

  context 'when success' do
    it 'returns success result' do
      authorized_graphql_post(
        query: move_project_in_area_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(Move::Project::InArea)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange id' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: move_project_in_area_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      before { allow_any_instance_of(TaskProject).to receive(:update!).and_raise(ActiveRecord::ActiveRecordError) }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: move_project_in_area_mutation,
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
          query: move_project_in_area_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
