# frozen_string_literal: true

describe Api::V1::Move::Note::Operation::InProject, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let_it_be(:current_user) { create(:user_account) }
  let(:project) { create(:note_project, with_notes: true, note_count: 4, user_account: current_user) }

  let(:first_note) { project.notes.find_by(position: 1) }
  let(:second_note) { project.notes.find_by(position: 2) }
  let(:third_note) { project.notes.find_by(position: 3) }
  let(:fourth_note) { project.notes.find_by(position: 4) }

  describe 'Success' do
    context 'when updated position in middle of the list' do
      let(:params) { { id: second_note.id, position: 3 } }

      it 'changes positions' do
        expect do
          execute_operation && first_note.reload && third_note.reload && fourth_note.reload && second_note.reload
        end.to change(second_note, :position).from(2).to(3).and(
          change(third_note, :position).from(3).to(2)
        ).and(
          avoid_changing(first_note, :position)
        ).and(
          avoid_changing(fourth_note, :position)
        )
      end

      it 'returns user_account' do
        expect(execute_operation['result']).to eq(completed: true)
      end

      it 'success operation' do
        expect(execute_operation).to be_success
      end
    end

    context 'when updated position in bottom of the list' do
      let(:params) { { id: third_note.id, position: 4 } }

      it 'changes positions' do
        expect do
          execute_operation && first_note.reload && third_note.reload && fourth_note.reload && second_note.reload
        end.to change(third_note, :position).from(3).to(4).and(
          change(fourth_note, :position).from(4).to(3)
        ).and(
          avoid_changing(first_note, :position)
        ).and(
          avoid_changing(second_note, :position)
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
      let(:params) { { id: first_note.id, position: 4 } }

      it 'changes positions' do
        expect do
          execute_operation && first_note.reload && third_note.reload && fourth_note.reload && second_note.reload
        end.to change(first_note, :position).from(1).to(4).and(
          change(fourth_note, :position).from(4).to(3)
        ).and(
          change(second_note, :position).from(2).to(1)
        ).and(
          change(third_note, :position).from(3).to(2)
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
      let(:params) { { id: first_note.id, position: 3 } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end
  end
end
