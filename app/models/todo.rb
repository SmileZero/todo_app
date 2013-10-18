class Todo < ActiveRecord::Base
	default_scope :order => 'todos.due'
end
