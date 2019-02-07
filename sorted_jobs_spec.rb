# frozen_string_literal: true

require 'rspec'
require './services/sorted_jobs'
require './jobs_sorter'

describe SortedJobs do
  let(:unsorted_jobs) { }

  subject(:subject) do
    described_class.new(unsorted_jobs).call
  end

  describe '#call' do
    context 'when jobs are present' do
      let(:unsorted_jobs) { 'a => , b => c, c => '}

      it 'returns the sorted job list' do
        sorter = class_double("JobsSorter")
        allow(sorter).to receive(:new).with(unsorted_jobs).and_return("a => , b => c, c => ")
        allow_any_instance_of(sorter).to receive(:sort).and_return(["a", "c", "b"])
        expect(subject).to eq(["a", "c", "b"])
      end
    end
  end
end
