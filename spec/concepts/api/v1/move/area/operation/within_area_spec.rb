# frozen_string_literal: true

describe Api::V1::Move::Area::Operation::WithinArea, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let_it_be(:current_user) { create(:user_account, with_note_areas: true, note_areas_count: 4) }

  let(:first_area) { current_user.note_areas.find_by(position: 1) }
  let(:second_area) { current_user.note_areas.find_by(position: 2) }
  let(:third_area) { current_user.note_areas.find_by(position: 3) }
  let(:fourth_area) { current_user.note_areas.find_by(position: 4) }

  describe 'Success' do
    context 'when updated position in middle of the list' do
      let(:params) { { id: second_area.id, position: 3 } }

      it 'changes positions' do
        expect {
          execute_operation && first_area.reload && third_area.reload && fourth_area.reload && second_area.reload
        }.to change(second_area, :position).from(2).to(3).and(
          change(third_area, :position).from(3).to(2)
        ).and(
          avoid_changing(first_area, :position)
        ).and(
          avoid_changing(fourth_area, :position)
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
      let(:params) { { id: third_area.id, position: 4 } }

      it 'changes positions' do
        expect {
          execute_operation && first_area.reload && third_area.reload && fourth_area.reload && second_area.reload
        }.to change(third_area, :position).from(3).to(4).and(
          change(fourth_area, :position).from(4).to(3)
        ).and(
          avoid_changing(first_area, :position)
        ).and(
          avoid_changing(second_area, :position)
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
      let(:params) { { id: first_area.id, position: 4 } }

      it 'changes positions' do
        expect {
          execute_operation && first_area.reload && third_area.reload && fourth_area.reload && second_area.reload
        }.to change(first_area, :position).from(1).to(4).and(
          change(fourth_area, :position).from(4).to(3)
        ).and(
          change(second_area, :position).from(2).to(1)
        ).and(
          change(third_area, :position).from(3).to(2)
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
    context 'when area not found' do
      let(:params) { { id: SecureRandom.uuid } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end

    context 'when area not belongs to user_account' do
      let(:first_area) { create(:note_area) }
      let(:params) { { id: first_area.id, area_id: second_area.id } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end
  end
end
