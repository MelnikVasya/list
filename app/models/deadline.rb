class Deadline < ActiveRecord::Base
  belongs_to :task
  validates :task_id, presence: true
  validates :deadline, presence: true
  def deadline_formatted
    deadline.strftime '%Y/%m/%d'
  end
  def deadline_formatted=(value)
    self.deadline = Time.parse(value) rescue nil
  end

end
