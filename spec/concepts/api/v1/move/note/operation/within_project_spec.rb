# frozen_string_literal: true

describe Api::V1::Move::Note::Operation::WithinProject, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let_it_be(:current_user) { create(:user_account) }

  let(:project) { create(:note_project, with_notes: true, note_count: 3, user_account: current_user) }
  let(:first_note) { project.notes.find_by(position: 1) }
  let(:second_note) { project.notes.find_by(position: 2) }
  let(:third_note) { project.notes.find_by(position: 3) }

  let(:another_project) { create(:note_project, with_notes: true, user_account: current_user) }
  let(:another_first_note) { another_project.notes.find_by(position: 1) }
  let(:another_second_note) { another_project.notes.find_by(position: 2) }

  describe 'Success' do
    context 'when changes position from on list to another' do
      let(:params) { { id: second_note.id, note_project_id: another_project.id } }

      it 'changes positions' do
        expect do
          execute_operation && first_note.reload && third_note.reload && second_note.reload &&
            another_first_note.reload && another_second_note.reload
        end.to change(second_note, :position).from(2).to(3).and(
          change(third_note, :position).from(3).to(2)
        ).and(
          avoid_changing(first_note, :position)
        ).and(
          avoid_changing(another_first_note, :position)
        ).and(
          avoid_changing(another_second_note, :position)
        )
      end

      it 'returns user_account' do
        expect(execute_operation['result']).to eq(completed: true)
      end

      it 'success operation' do
        expect(execute_operation).to be_success
      end
    end

    context 'when updated position at top of the list' do
      let(:params) { { id: first_note.id, note_project_id: another_project.id } }

      it 'changes positions' do
        expect do
          execute_operation && first_note.reload && third_note.reload && second_note.reload &&
            another_first_note.reload && another_second_note.reload
        end.to change(first_note, :position).from(1).to(3).and(
          change(third_note, :position).from(3).to(2)
        ).and(
          change(second_note, :position).from(2).to(1)
        ).and(
          avoid_changing(another_first_note, :position)
        ).and(
          avoid_changing(another_second_note, :position)
        )
      end

      it 'returns user_account' do
        expect(execute_operation['result']).to eq(completed: true)
      end

      it 'success operation' do
        expect(execute_operation).to be_success
      end
    end
  end

  describe 'Failure ' do
    context 'when note not found' do
      let(:params) { { id: SecureRandom.uuid } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end

    context 'when note not belongs to user_account' do
      let(:first_note) { create(:note) }
      let(:params) { { id: first_note.id, note_project_id: another_project.id } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end

    context 'when project not belongs to user_account' do
      let(:another_project) { create(:note_project) }
      let(:params) { { id: first_note.id, note_project_id: another_project.id } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end
  end
end
