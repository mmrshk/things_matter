# frozen_string_literal: true

describe Api::V1::User::Note::Operation::Delete, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:note_project, user_account: current_user) }
  let(:note) { create(:note, note_project: project) }

  let(:params) { { id: note.id } }

  before { note }

  context 'when user deletes note' do
    it 'deletes note' do
      expect { execute_operation }.to change(Note, :count).from(1).to(0)
    end

    it 'returns success result' do
      expect(execute_operation['result'][:completed]).to eq(true)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when note id NOT exist' do
    let(:params) { { id: SecureRandom.uuid } }

    it 'NOT deletes note' do
      expect { execute_operation }.not_to change(Note, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:note_project) }

    it 'NOT deletes note' do
      expect { execute_operation }.not_to change(Note, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end
