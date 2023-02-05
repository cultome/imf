class IMF::Task::Base
  attr_reader :status, :stage, :requirements, :constraints, :stakeholders, :objectives, :costs, :assignees

  # The allowed values for each "data section" are as follow:
  # nil: the section wont be available (none)
  # class: the section is available and required to fill (open)
  # instance: the section is available but not editable (fixed)
  # empty array: error
  #
  # @param [Array(Requirement)] requirements
  # @param [Array(Constraint)] constraints
  # @param [Array(Stakeholder)] stakeholders
  # @param [Array(Objective)] objectives
  # @param [Array(Const)] costs
  # @param [Array(Stakeholder)] assignees
  def initialize(
    status: 'pending',
    stage: nil,
    requirements: nil,
    constraints: nil,
    stakeholders: nil,
    objectives: nil,
    costs: nil,
    assignees: nil)

    @status = status
    @stage = stage

    check_param! requirements, 'Requirements'
    check_param! constraints, 'Constraints'
    check_param! stakeholders, 'Stakeholders'
    check_param! objectives, 'Objectives'
    check_param! costs, 'Costs'
    check_param! assignees, 'Assignees'

    @requirements = requirements
    @constraints = constraints
    @stakeholders = stakeholders
    @objectives = objectives
    @costs = costs
    @assignees = assignees
  end

  private

  def check_param!(value, name)
    raise "#{name} list cannot be empty" if !value.nil? && value.empty?
  end
end
