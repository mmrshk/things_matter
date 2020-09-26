# frozen_string_literal: true

describe Api::V1::User::Note::Operation::Update, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:note_project, user_account: current_user) }
  let(:note) { create(:note, note_project: project) }
  let(:name) { FFaker::Lorem.word }
  let(:description) { FFaker::Lorem.sentence }

  let(:params) { { id: note.id, name: name, description: description } }

  context 'when user updates project' do
    it 'updates project' do
      expect { execute_operation && note.reload }.to change(note, :name).from(note.name).to(name)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user changes project for note' do
    let(:new_project) { create(:note_project, user_account: current_user) }
    let(:params) { { id: note.id, note_project_id: new_project.id } }

    it 'updates project' do
      expect do
        execute_operation && note.reload
      end.to change(note, :note_project_id).from(note.note_project_id).to(new_project.id)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when note id NOT exist' do
    let(:params) { { id: SecureRandom.uuid, name: name } }

    it 'NOT updates project' do
      expect { execute_operation && project.reload }.not_to change(project, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:note_project) }

    it 'NOT updates project' do
      expect { execute_operation && project.reload }.not_to change(project, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end
