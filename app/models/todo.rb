class Todo < ActiveRecord::Base
	validates :task, presence: true
	validates_presence_of :due
	default_scope :order => 'todos.due'

	belongs_to :user
end
