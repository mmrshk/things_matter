# frozen_string_literal: true

describe TrashCleanupService do
  subject(:service) { described_class.call }

  let!(:task_area) { create(:task_area, is_deleted: true) }
  let!(:task_project) { create(:task_project, task_area: task_area, is_deleted: true, with_area: false) }
  let!(:task) { create(:task, task_project: task_project, is_deleted: true) }

  let!(:note_area) { create(:note_area, is_deleted: true) }
  let!(:note_project) { create(:note_project, note_area: note_area, is_deleted: true) }
  let!(:note) { create(:note, note_project: note_project, is_deleted: true) }

  context 'when removes all entities' do
    it 'success' do
      expect { service }.to change(TaskProject, :count).from(1).to(0).and(
        change(NoteProject, :count).from(1).to(0)
      ).and(
        change(TaskArea, :count).from(1).to(0)
      ).and(
        change(NoteArea, :count).from(1).to(0)
      ).and(
        change(Task, :count).from(1).to(0)
      ).and(
        change(Note, :count).from(1).to(0)
      )
    end
  end
end
