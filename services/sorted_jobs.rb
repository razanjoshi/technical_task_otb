# frozen_string_literal: true

# This class returns sorted list of jobs
class SortedJobs
  attr_reader :unsorted_jobs
  def initialize(unsorted_jobs)
    @unsorted_jobs = unsorted_jobs
  end
  
  def call
    jobs = JobsSorter.new(unsorted_jobs)
    jobs.sort
  end
end
