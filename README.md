# README

This is a technical task performed for a Ruby on Rails Developer Job Interview.

Things you may want to cover:

* Clone the repo by 
`git clone git@github.com:razanjoshi/technical_task_otb.git`

* Get to the working directory
 `cd technical_task_otb`

* In the terminal, type `irb` and Enter
`require './services/sorted_jobs.rb'`
`require './jobs_sorter.rb'`

* Running the main class
`SortedJobs.new("a => , b => , c => ").call`

* Outupt
`["a", "b", "c"]`

* How to run the test suite: Exit the irb and type
`rspec sorted_jobs_spec.rb`
`rspec jobs_sorter_spec.rb`
