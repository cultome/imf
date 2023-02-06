class IMF::Process::Template
  attr_reader :id, :stages

  # @params [Array(IMF::Process::Stage::Template)] stages
  def initialize(id:, stages:)
    @id = id
    @stages = stages
  end

  # Validates the input, overwrite values and enrich information for tasks
  #
  # @param [Hash(String, Hash(#to_s, *))] input_stages values to build tasks in each stage
  # @return [Array(IMF::Task::Base)]
  def materialize(input_stages = {})
    process = IMF::Process::Base.new id: SecureRandom.uuid

    stages.flat_map do |t_stage|
      stage = IMF::Process::Stage::Base.new(
        id: t_stage.id,
        dependencies: t_stage.dependencies,
      )

      extra_data = { stage:, process:, id: SecureRandom.uuid }
      i_stage = input_stages.fetch(t_stage.id, [])

      if i_stage.empty?
        t_stage.task_template.materialize extra_data
      else
        i_stage.map do |task_data|
          extra_data.delete(:id) if task_data.key?(:id)

          t_stage.task_template.materialize task_data.merge(extra_data)
        end
      end
    end
  end
end
