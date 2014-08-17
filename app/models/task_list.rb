class TaskList < ActiveRecord::Base
  include ActionView::Helpers
  belongs_to :user
  has_many   :tasks, dependent: :destroy
  default_scope { order('id DESC') }
  validates :user_id, presence: true
  validates :header, presence: true, length: { maximum: 140}
end
