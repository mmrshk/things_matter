# frozen_string_literal: true

describe Api::V1::Move::Project::Operation::InArea, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let_it_be(:current_user) { create(:user_account) }
  let(:area) { create(:task_area, with_projects: true, project_count: 4, user_account: current_user) }

  let(:first_project) { area.task_projects.find_by(position: 1) }
  let(:second_project) { area.task_projects.find_by(position: 2) }
  let(:third_project) { area.task_projects.find_by(position: 3) }
  let(:fourth_project) { area.task_projects.find_by(position: 4) }

  describe 'Success' do
    context 'when updated position in middle of the list' do
      let(:params) { { id: second_project.id, position: 3 } }

      it 'changes positions' do
        expect {
          execute_operation && first_project.reload && third_project.reload && fourth_project.reload && second_project.reload
        }.to change(second_project, :position).from(2).to(3).and(
          change(third_project, :position).from(3).to(2)
        ).and(
          avoid_changing(first_project, :position)
        ).and(
          avoid_changing(fourth_project, :position)
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
      let(:params) { { id: third_project.id, position: 4 } }

      it 'changes positions' do
        expect {
          execute_operation && first_project.reload && third_project.reload && fourth_project.reload && second_project.reload
        }.to change(third_project, :position).from(3).to(4).and(
          change(fourth_project, :position).from(4).to(3)
        ).and(
          avoid_changing(first_project, :position)
        ).and(
          avoid_changing(second_project, :position)
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
      let(:params) { { id: first_project.id, position: 4 } }

      it 'changes positions' do
        expect {
          execute_operation && first_project.reload && third_project.reload && fourth_project.reload && second_project.reload
        }.to change(first_project, :position).from(1).to(4).and(
          change(fourth_project, :position).from(4).to(3)
        ).and(
          change(second_project, :position).from(2).to(1)
        ).and(
          change(third_project, :position).from(3).to(2)
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
      let(:params) { { id: first_project.id, position: 3 } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end
  end
end
