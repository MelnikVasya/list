class Task < ActiveRecord::Base
  belongs_to :task_list
  belongs_to :user
  default_scope { order('position ASC') }
  acts_as_list scope: :task_list
  validates :task_list_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  before_create :create_mark_position

  private
    def create_mark_position
      self.mark = false
      self.position = bottom_position_in_list + 1
    end
end
