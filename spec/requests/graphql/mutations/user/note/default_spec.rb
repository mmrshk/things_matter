# frozen_string_literal: true

describe 'mutation userNoteDefault', type: :request do
  let(:current_user) { create(:user_account) }
  let(:variables) { { input: { id: note.id } } }
  let(:project) { create(:note_project, user_account: current_user) }
  let(:note) { create(:note, note_project: project) }
  let(:default_note) { create(:note, note_project: project, default: true) }

  let(:token) { generate_token(account_id: current_user.id) }

  before do
    note
    default_note
  end

  context 'when success' do
    it 'returns updated note of current_user' do
      authorized_graphql_post(
        query: user_note_default_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserNote::DefaultSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when note not found' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_note_default_mutation,
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
          query: user_note_default_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end
