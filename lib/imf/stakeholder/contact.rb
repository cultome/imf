# Base class for contacts informations (means of communication).
# Specialized classes will overwrite the methods defined in here
class IMF::Stakeholder::Contact
  attr_reader :value

  # @param [String] value
  def initialize(value)
    @value = value
  end
end
