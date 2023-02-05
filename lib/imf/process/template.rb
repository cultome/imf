class IMF::Process::Template
  attr_reader :stages

  # @params [Array(IMF::Process::Stage::Template)] stages
  def initialize(stages:)
    @stages = stages
  end

  # Validates the input, overwrite values and enrich information for tasks
  #
  # @param [Hash(String, Hash(#to_s, *))] input_stages values to build tasks in each stage
  # @return [Array(IMF::Task::Base)]
  def materialize(input_stages = {})
    stages.flat_map do |t_stage|
      stage = IMF::Process::Stage::Base.new(
        id: t_stage.id,
        dependencies: t_stage.dependencies,
      )

      i_stage = input_stages.fetch(t_stage.id, [])

      if i_stage.empty?
        t_stage.task_template.materialize
      else
        i_stage.map do |task_data|
          t_stage.task_template.materialize task_data.merge(stage: stage)
        end
      end
    end
  end
end
