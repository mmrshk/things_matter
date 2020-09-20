# frozen_string_literal: true

describe Api::V1::Move::Task::Operation::WithinProject, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let_it_be(:current_user) { create(:user_account) }

  let(:project) { create(:task_project, with_tasks: true, task_count: 3, user_account: current_user) }
  let(:first_task) { project.tasks.find_by(position: 1) }
  let(:second_task) { project.tasks.find_by(position: 2) }
  let(:third_task) { project.tasks.find_by(position: 3) }

  let(:another_project) { create(:task_project, with_tasks: true, user_account: current_user) }
  let(:another_first_task) { another_project.tasks.find_by(position: 1) }
  let(:another_second_task) { another_project.tasks.find_by(position: 2) }

  describe 'Success' do
    context 'when changes position from on list to another' do
      let(:params) { { id: second_task.id, task_project_id: another_project.id } }

      it 'changes positions' do
        expect do
          execute_operation && first_task.reload && third_task.reload && second_task.reload &&
            another_first_task.reload && another_second_task.reload
        end.to change(second_task, :position).from(2).to(3).and(
          change(third_task, :position).from(3).to(2)
        ).and(
          avoid_changing(first_task, :position)
        ).and(
          avoid_changing(another_first_task, :position)
        ).and(
          avoid_changing(another_second_task, :position)
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
      let(:params) { { id: first_task.id, task_project_id: another_project.id } }

      it 'changes positions' do
        expect do
          execute_operation && first_task.reload && third_task.reload && second_task.reload &&
            another_first_task.reload && another_second_task.reload
        end.to change(first_task, :position).from(1).to(3).and(
          change(third_task, :position).from(3).to(2)
        ).and(
          change(second_task, :position).from(2).to(1)
        ).and(
          avoid_changing(another_first_task, :position)
        ).and(
          avoid_changing(another_second_task, :position)
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
    context 'when task not found' do
      let(:params) { { id: SecureRandom.uuid } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end

    context 'when task not belongs to user_account' do
      let(:first_task) { create(:task) }
      let(:params) { { id: first_task.id, task_project_id: another_project.id } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end

    context 'when project not belongs to user_account' do
      let(:another_project) { create(:task_project) }
      let(:params) { { id: first_task.id, task_project_id: another_project.id } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end
  end
end
