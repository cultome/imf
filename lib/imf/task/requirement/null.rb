class IMF::Task::Requirement::NullOne < IMF::Task::Requirement::Base
end

class IMF::Task::Requirement::NullTwo < IMF::Task::Requirement::Base
  attr_reader :val1, :val2

  def initialize(id:, val1:, val2:)
    super id:

    @val1 = val1
    @val2 = val2
  end
end
