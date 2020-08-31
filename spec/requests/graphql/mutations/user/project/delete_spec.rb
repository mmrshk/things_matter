# frozen_string_literal: true

describe 'mutation userAreaDelete', type: :request do
  let(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }
  let(:project) { create(:project, user_account: user_account) }

  let(:variables) { { input: { id: project.id } } }

  context 'when success' do
    it 'returns updated project of current_user' do
      authorized_graphql_post(
        query: user_project_delete_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserProject::DeleteSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when project not found' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_project_delete_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ExecutionErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when project not belongs to current user' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_project_delete_mutation,
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
          query: user_project_delete_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
