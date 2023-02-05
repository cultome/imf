class IMF::Task::Template
  attr_reader :requirements, :constraints, :stakeholders, :objectives, :costs, :assignees

  # The allowed values for each "data section" are as follow:
  # nil: the section wont be available (none)
  # class: the section is available and required to fill (open)
  # instance: the section is available but not editable (fixed)
  #
  # @param [Array(Requirement)] requirements
  # @param [Array(Constraint)] constraints
  # @param [Array(Stakeholder)] stakeholders
  # @param [Array(Objective)] objectives
  # @param [Array(Const)] costs
  # @param [Array(Stakeholder)] assignees
  def initialize(
    requirements: nil,
    constraints: nil,
    stakeholders: nil,
    objectives: nil,
    costs: nil,
    assignees: nil)
    @requirements = requirements
    @constraints = constraints
    @stakeholders = stakeholders
    @objectives = objectives
    @costs = costs
    @assignees = assignees
  end
end
