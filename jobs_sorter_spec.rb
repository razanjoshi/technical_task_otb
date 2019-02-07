# frozen_string_literal: true

require 'rspec'
require './jobs_sorter'

describe JobsSorter do
  let(:unsorted_jobs) { }

  subject(:subject) do
    described_class.new(unsorted_jobs)&.sort
  end

  describe '#call' do
    context 'when jobs hash no jobs' do
      let(:unsorted_jobs) { }

      it 'returns sorted job list with the one given job' do
        expect(subject).to eq([])
      end
    end

    context 'when jobs hash one job with no dependency' do
      let(:unsorted_jobs) { 'a => '}

      it 'returns sorted job list with the one given job' do
        expect(subject).to eq(["a"])
      end
    end

    context 'when jobs hash three jobs with no dependency' do
      let(:unsorted_jobs) { 'a => , b => , c => '}

      it 'returns sorted job list with the one given job' do
        expect(subject).to eq(["a", "b", "c"])
      end
    end

    context 'when jobs hash three jobs with one dependency' do
      let(:unsorted_jobs) { 'a => , b => c, c => ' }

      it 'returns sorted job list with the one given job' do
        expect(subject).to eq(["a", "c", "b"])
      end
    end

    context 'when jobs hash six jobs with four different dependencies' do
      let(:unsorted_jobs) { 'a => , b => c, c => f, d => a, e => b, f => ' }

      it 'returns sorted job list with the one given job' do
        expect(subject).to eq(["a", "f", "c", "b", "d", "e"])
      end
    end

    context 'when jobs hash three jobs with one dependency same as its job' do
      let(:unsorted_jobs) { 'a => , b => , c => c' }

      it 'returns sorted job list with the one given job' do
        expect{ subject }.to raise_error(JobsSorter::SelfDependencyError, "Jobs can not depend on themselves.")
      end
    end

    context 'when jobs hash three jobs with one dependency same as its job' do
      let(:unsorted_jobs) { 'a => , b => c, c => f, d => a, e => , f => b' }

      it 'returns sorted job list with the one given job' do
        expect{ subject }.to raise_error(JobsSorter::CircularReferenceError, "Jobs can not have circular dependencies")
      end
    end
  end
end
