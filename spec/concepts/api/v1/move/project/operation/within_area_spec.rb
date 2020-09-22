# frozen_string_literal: true

describe Api::V1::Move::Project::Operation::WithinAreaStrategy, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let_it_be(:current_user) { create(:user_account) }

  let(:area) { create(:note_area, with_projects: true, project_count: 3, user_account: current_user) }
  let(:first_project) { area.note_projects.find_by(position: 1) }
  let(:second_project) { area.note_projects.find_by(position: 2) }
  let(:third_project) { area.note_projects.find_by(position: 3) }

  let(:another_area) { create(:note_area, with_projects: true, user_account: current_user) }
  let(:another_first_project) { another_area.note_projects.find_by(position: 1) }
  let(:another_second_project) { another_area.note_projects.find_by(position: 2) }

  describe 'Success' do
    context 'when changes position from on list to another' do
      let(:params) { { id: second_project.id, area_id: another_area.id } }

      it 'changes positions' do
        expect do
          execute_operation && first_project.reload && third_project.reload && second_project.reload &&
            another_first_project.reload && another_second_project.reload
        end.to change(second_project, :position).from(2).to(3).and(
          change(third_project, :position).from(3).to(2)
        ).and(
          avoid_changing(first_project, :position)
        ).and(
          avoid_changing(another_first_project, :position)
        ).and(
          avoid_changing(another_second_project, :position)
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
      let(:params) { { id: first_project.id, area_id: another_area.id } }

      it 'changes positions' do
        expect do
          execute_operation && first_project.reload && third_project.reload && second_project.reload &&
            another_first_project.reload && another_second_project.reload
        end.to change(first_project, :position).from(1).to(3).and(
          change(third_project, :position).from(3).to(2)
        ).and(
          change(second_project, :position).from(2).to(1)
        ).and(
          avoid_changing(another_first_project, :position)
        ).and(
          avoid_changing(another_second_project, :position)
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

  context 'Failure ' do
    context 'when project not found' do
      let(:params) { { id: SecureRandom.uuid } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end

    context 'when project not belongs to user_account' do
      let(:first_project) { create(:task_project) }
      let(:params) { { id: first_project.id, area_id: another_area.id } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end

    context 'when area not belongs to user_account' do
      let(:another_area) { create(:note_area) }
      let(:params) { { id: first_project.id, area_id: another_area.id } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end
  end
end
