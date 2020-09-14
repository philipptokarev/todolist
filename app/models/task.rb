class Task < ApplicationRecord
  belongs_to :project

  acts_as_list
  default_scope {order(status: :asc, position: :asc)}
end
