task default: ['test']

task test: [:lint, :style, :unit]

desc 'Run FoodCritic (lint) tests'
task :lint do
  sh %(chef exec foodcritic --epic-fail any .)
end

desc 'Run RuboCop (style) tests'
task :style do
  sh %(chef exec rubocop)
end

desc 'Run RSpec (unit) tests'
task :unit do
  sh %(chef exec rspec --format documentation)
end
