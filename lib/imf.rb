# frozen_string_literal: true

require_relative 'imf/version'

module IMF
  extend self

  # @param [String] email
  def build_email_contact(email)
    IMF::Stakeholder::EmailContact.new email
  end

  # @param [String] name
  # @param [Array(Contact)] name
  def build_client(name, contacts)
    IMF::Stakeholder::ClientPerson.new name, contacts
  end

  # @param [Array(Stage)] dependencies
  # @param [Task::Template] task_template
  # @param [boolean] multitask
  def build_stage_template(dependencies, task_template, multitask)
    IMF::Process::Stage::Template.new dependencies, task_template, multitask
  end

  # @params [Array(Stage)] stages
  def build_process_template(stages)
    IMF::Process::Template.new stages
  end

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
  def build_task_template(
    requirements: nil,
    constraints: nil,
    stakeholders: nil,
    objectives: nil,
    costs: nil,
    assignees: nil)
    IMF::Task::Template.new(
      requirements:,
      constraints:,
      stakeholders:,
      objectives:,
      costs:,
      assignees:
    )
  end
end

require_relative './imf/stakeholder'
require_relative './imf/task'
require_relative './imf/process'
