class IMF::Task::Constraint::Base
  include IMF::Role::Typeable

  attr_reader :id

  def initialize(id:)
    @id = id
  end
end
