module IMF::Task::EventTransitions
  Basic = {
    'created' => {
      'start_task' => 'started',
      '*' => 'created',
    },
    'started' => {
      'complete_success' => 'completed_succeeded',
      'complete_fail' => 'completed_failed',
    },
    'completed_succeeded' => {
      'complete_fail' => 'completed_failed',
      '*' => 'completed_succeeded',
    },
    'completed_failed' => {
      'complete_success' => 'completed_succeeded',
      '*' => 'completed_failed',
    },
  }
end
