# Base class for contacts informations (means of communication).
# Specialized classes will overwrite the methods defined in here
class IMF::Task::Stakeholder::Contact
  attr_reader :id, :value

  # @param [String] value
  def initialize(id:, value:)
    @id = id
    @value = value
  end
end
