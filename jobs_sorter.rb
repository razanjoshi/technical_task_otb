# frozen_string_literal: true

# A Ruby Class to sort jobs according to their dependencies
class JobsSorter
  require 'pry'

  def initialize(unstructured_jobs)
    @jobs_hash = job_parser(unstructured_jobs)
    @labeled = label_jobs
  end

  def job_parser(unstructured_jobs)
    jobs_hash = {}
    s_jobs = unstructured_jobs.split(", ")
    s_jobs.each do |s|
      key, value = s.split(" => ")
      if key === value
        ## raise self_dependency_error if key == value
      else
        jobs_hash[key] = value
      end
    end
    jobs_hash
  end

  private

  def label_jobs
    labeled = {}
    @jobs_hash.each do |key, value|
      labeled[key] = "incomplete"
    end
    labeled
  end
end
