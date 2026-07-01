# frozen_string_literal: true

name 'fastly'

run_list 'recipe[fastly_test::default]'

cookbook 'fastly', path: '.'
cookbook 'apt', git: 'https://github.com/sous-chefs/apt.git', branch: 'main'
cookbook 'fastly_test', path: './test/fixtures/cookbooks/fastly_test'

Dir.children('./test/fixtures/cookbooks/fastly_test/recipes').grep(/\.rb\z/).sort.each do |recipe|
  recipe_name = File.basename(recipe, '.rb')

  named_run_list recipe_name.to_sym, 'fastly_test::' + recipe_name
end
