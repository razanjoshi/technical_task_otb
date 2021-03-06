# frozen_string_literal: true

# A Ruby Class to sort jobs according to their dependencies
class JobsSorter
  attr_reader :sorted_jobs

  class SelfDependencyError < StandardError
    MESSAGE = 'Jobs can not depend on themselves.'
  end

  class CircularReferenceError < StandardError
    MESSAGE = 'Jobs can not have circular dependencies'
  end

  def initialize(unstructured_jobs)
    @parsed_jobs = job_parser(unstructured_jobs)
    @labeled = label_jobs
    @sorted_jobs = []
  end

  def job_parser(unstructured_jobs)
    jobs_hash = {}
    s_jobs = unstructured_jobs&.split(", ")
    if s_jobs
      s_jobs.each do |s|
        key, value = s.split(" => ")
        if key === value
          # The key and value can not be same as same job can't depend on themselves.
          raise SelfDependencyError, SelfDependencyError::MESSAGE if key == value
        else
          jobs_hash[key] = value
        end
      end
    end
    jobs_hash
  end

  def sort
    while @labeled.values.include?('incomplete')
      @labeled.each_pair do |job, status|
        sort_jobs(job) if status == 'incomplete'
      end
    end
    @sorted_jobs
  end

  private

  def label_jobs
    labeled = {}
    @parsed_jobs.each do |key, value|
      labeled[key] = 'incomplete'
    end
    labeled
  end

  def sort_jobs(job)
    if @labeled[job]&.include? 'inprogress'
      raise CircularReferenceError, CircularReferenceError::MESSAGE
    elsif @labeled[job]&.include? 'incomplete'
      @labeled[job] = 'inprogress'
      build_list(job)
    end
  end

  def build_list(job)
    unless @parsed_jobs[job]&.empty?
      sort_jobs(@parsed_jobs[job])
    end
    @labeled[job] = 'complete'
    @sorted_jobs.push(job)
  end
end
