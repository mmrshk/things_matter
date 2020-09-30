# frozen_string_literal: true

describe Api::V1::User::Note::Operation::Default, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:note_project, user_account: current_user) }
  let(:note) { create(:note, note_project: project) }
  let(:default_note) { create(:note, note_project: project, default: true) }

  let(:params) { { id: note.id } }

  before do
    note
    default_note
  end

  context 'when user deletes note' do
    it 'updates note' do
      expect { execute_operation && note.reload }.to change(note, :default).from(false).to(true)
    end

    it 'updates default note' do
      expect { execute_operation && default_note.reload }.to change(default_note, :default).from(true).to(false)
    end

    it 'returns success result' do
      expect(execute_operation['result'][:completed]).to be_truthy
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
