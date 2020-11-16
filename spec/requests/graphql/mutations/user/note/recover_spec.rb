# frozen_string_literal: true

describe 'mutation userNoteRecover', type: :request do
  let(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }

  let(:variables) { { input: { id: note.id } } }

  let(:note) { create(:note, note_project: project) }
  let(:project) { create(:note_project, user_account: user_account) }

  context 'when success' do
    context 'when exist project' do
      it 'returns updated note of current_user' do
        authorized_graphql_post(
          query: user_note_recover_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(UserNote::RecoverSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when project NOT exist' do
      let(:project) { create(:note_project, user_account: user_account) }
      let(:note) { create(:note, user_account: user_account) }
      let(:variables) { { input: { id: note.id, note_project_id: project.id } } }

      before { note.note_project.destroy }

      it 'returns updated note of current_user' do
        authorized_graphql_post(
          query: user_note_recover_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(UserNote::RecoverSchema)
        expect(response.status).to be(200)
      end
    end
  end

  context 'when failed' do
    context 'when note not found' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_note_recover_mutation,
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
          query: user_note_recover_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
