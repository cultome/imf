class IMF::Task::Template
  attr_reader :id, :requirements, :constraints, :stakeholders, :objectives, :costs, :assignees, :transitions

  # The allowed values for each "data section" are as follow:
  # nil: the section wont be available (none)
  # class: the section is available and required to fill (open)
  # instance: the section is available but not editable (fixed)
  # empty array: error
  #
  # @param [String] id
  # @param [Array(Requirement)] requirements
  # @param [Array(Constraint)] constraints
  # @param [Array(Stakeholder)] stakeholders
  # @param [Array(Objective)] objectives
  # @param [Array(Const)] costs
  # @param [Array(Stakeholder)] assignees
  # @param [IMF::Task::EventTransitions] transitions
  def initialize(
    id:,
    requirements: nil,
    constraints: nil,
    stakeholders: nil,
    objectives: nil,
    costs: nil,
    assignees: nil,
    transitions: IMF::Task::EventTransitions::Basic
  )
    @id = id
    @transitions = transitions

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

  def section_names
    @section_names ||= %I[requirements constraints stakeholders objectives costs assignees]
  end

  # @param [Hash(Symbol, *)] data task parameters
  def materialize(data = {})
    task_params = section_names.each_with_object({}) do |section_name, task_acc|
      t_sections = send section_name

      if t_sections.nil?
        # is closed
        unless data[section_name].nil? || data[section_name].empty?
          raise "Not allowed to overwrite a closed section: #{section_name}"
        end

        next
      end

      section_objs = t_sections.flat_map do |t_section|
        section_datas = data.fetch(section_name, []).select { |d| d[:type] == t_section.as_type }

        if t_section.is_a? Class
          # is open
          raise "Required data for open section [#{section_name}]" if section_datas.empty?

          section_datas.map { |s_data| materialize_section section_name, s_data }
        else
          # is fixed
          unless section_datas.empty?
            raise "Not allowed to overwrite a fixed section [#{section_name}] with #{section_datas}"
          end

          t_section
        end
      end

      task_acc[section_name] = section_objs
    end

    non_section_props = data.select { |k, v| !section_names.include? k }
    non_section_props[:transitions] = @transitions unless non_section_props.key?(:transitions)
    non_section_props[:id] = SecureRandom.uuid unless non_section_props.key?(:id)

    IMF::Task::Base.new(**task_params.merge(non_section_props))
  end

  private

  def materialize_section(section_name, data)
    class_name = "IMF::Task::#{section_name.to_singular.to_pascalcase}::#{data[:type].to_pascalcase}"

    data[:params][:id] = SecureRandom.uuid if data.dig(:params, :id).nil?

    Object.const_get(class_name).new(**data[:params])
  end

  def check_param!(value, name)
    raise "#{name} list cannot be empty" if !value.nil? && value.empty?
  end
end
