# frozen_string_literal: true

describe Api::V1::Move::Task::Operation::InProject, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let_it_be(:current_user) { create(:user_account) }
  let(:project) { create(:task_project, with_tasks: true, task_count: 4, user_account: current_user) }

  let(:first_task) { project.tasks.find_by(position: 1) }
  let(:second_task) { project.tasks.find_by(position: 2) }
  let(:third_task) { project.tasks.find_by(position: 3) }
  let(:fourth_task) { project.tasks.find_by(position: 4) }

  describe 'Success' do
    context 'when updated position in middle of the list' do
      let(:params) { { id: second_task.id, position: 3 } }

      it 'changes positions' do
        expect {
          execute_operation && first_task.reload && third_task.reload && fourth_task.reload && second_task.reload
        }.to change(second_task, :position).from(2).to(3).and(
          change(third_task, :position).from(3).to(2)
        ).and(
          avoid_changing(first_task, :position)
        ).and(
          avoid_changing(fourth_task, :position)
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
      let(:params) { { id: third_task.id, position: 4 } }

      it 'changes positions' do
        expect {
          execute_operation && first_task.reload && third_task.reload && fourth_task.reload && second_task.reload
        }.to change(third_task, :position).from(3).to(4).and(
          change(fourth_task, :position).from(4).to(3)
        ).and(
          avoid_changing(first_task, :position)
        ).and(
          avoid_changing(second_task, :position)
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
      let(:params) { { id: first_task.id, position: 4 } }

      it 'changes positions' do
        expect {
          execute_operation && first_task.reload && third_task.reload && fourth_task.reload && second_task.reload
        }.to change(first_task, :position).from(1).to(4).and(
          change(fourth_task, :position).from(4).to(3)
        ).and(
          change(second_task, :position).from(2).to(1)
        ).and(
          change(third_task, :position).from(3).to(2)
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
      let(:params) { { id: first_task.id, position: 3 } }

      it 'fails operation' do
        expect(execute_operation).to be_failure
      end
    end
  end
end
