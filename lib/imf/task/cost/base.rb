class IMF::Task::Cost::Base
  include IMF::Role::Typeable

  def initialize(id:)
    @id = id
  end
end
