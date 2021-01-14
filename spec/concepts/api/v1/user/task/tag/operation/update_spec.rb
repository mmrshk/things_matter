# frozen_string_literal: true

describe Api::V1::User::Task::Tag::Operation::Update, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:task) { create(:task, user_account: current_user) }
  let(:task_tag) { create(:task_tag, task: task) }
  let(:name) { FFaker::Lorem.word }
  let(:params) { { name: name, id: task_tag.id } }

  context 'when user updates task tag' do
    it 'updates TaskTag' do
      expect { execute_operation && task_tag.reload }.to change(task_tag, :name).from(task_tag.name).to(name)
    end

    it 'returns status' do
      expect(execute_operation['result']).to be_truthy
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user not passes id' do
    let(:params) { { name: name } }

    it 'NOT updates TaskTag' do
      expect { execute_operation && task_tag.reload }.not_to change(task_tag, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:task_tag) { create(:task_tag) }

    it 'NOT updates TaskTag' do
      expect { execute_operation && task_tag.reload }.not_to change(task_tag, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end
