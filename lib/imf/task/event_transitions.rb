module IMF::Task::EventTransitions
  Basic = {
    'created' => {
      'start_task' => 'started',
      '*' => 'created',
      '_final?' => false,
    },
    'started' => {
      'complete_success' => 'completed_succeeded',
      'complete_fail' => 'completed_failed',
      '*' => 'started',
      '_final?' => false,
    },
    'completed_succeeded' => {
      'complete_fail' => 'completed_failed',
      '*' => 'completed_succeeded',
      '_final?' => true,
    },
    'completed_failed' => {
      'complete_success' => 'completed_succeeded',
      '*' => 'completed_failed',
      '_final?' => true,
    },
  }
end
