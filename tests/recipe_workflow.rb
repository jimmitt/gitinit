# Run with ruby tests/recipe_workflow.rb. All Git writes stay in a new /tmp directory.
# Uses real Git IDs, not the deliberately illustrative hashes in the tutorial.
require 'tmpdir'
require 'open3'
require 'fileutils'

ENV['GIT_CONFIG_GLOBAL'] = File::NULL
ENV['GIT_CONFIG_NOSYSTEM'] = '1'
ENV['GIT_TERMINAL_PROMPT'] = '0'
ENV['GIT_EDITOR'] = 'true'
ROOT = Dir.mktmpdir('gitinit-recipe-')
puts "Test repositories: #{ROOT}"
def git(repo, *args, success: true)
  out, err, status = Open3.capture3('git', '-C', repo, *args)
  raise "git #{args.join(' ')}: #{out}#{err}" if status.success? != success
  out + err
end
def check(value, message)
  raise message unless value
  puts "PASS: #{message}"
end
def identity(repo)
  git(repo, 'config', 'user.name', 'Tutorial Test')
  git(repo, 'config', 'user.email', 'tutorial@example.com')
end
def edit(repo)
  file = File.join(repo, 'guac')
  File.write(file, yield(File.read(file)))
end
def commit(repo, message)
  git(repo, 'add', 'guac')
  git(repo, 'commit', '-m', message)
  git(repo, 'rev-parse', 'HEAD').strip
end
def text(repo)
  File.read(File.join(repo, 'guac'))
end
central = File.join(ROOT, 'central.git')
joel = File.join(ROOT, 'joel')
rose = File.join(ROOT, 'rose')
git(ROOT, 'init', '--bare', '-b', 'main', central)
check(git(central, 'show-ref', success: false).empty?, 'empty bare repository has no refs')
git(ROOT, 'clone', central, joel)
identity(joel)
File.write(File.join(joel, 'guac'), <<~RECIPE)
  * 2 ripe avocados
  * 1/2 red onion, minced (about 1/2 cup)
  * 1-2 serrano chiles, stems and seeds removed, minced
  * 2 tablespoons cilantro leaves, finely chopped
  * 1 tablespoon of fresh lime or lemon juice
  * 1/2 teaspoon coarse salt
  * A dash of freshly grated black pepper
  * 1/2 ripe tomato, seeds and pulp removed, chopped

  Crunch all ingredients together.
  Serve with tortilla chips.
RECIPE
commit(joel, 'Initial version of guacamole recipe')
edit(joel) { |s| s.sub('Crunch', 'Smoosh') }
commit(joel, 'Change crunch to smoosh')
git(joel, 'push', '-u', 'origin', 'main')
git(ROOT, 'clone', central, rose)
identity(rose)
edit(rose) { |s| s.sub('serrano', 'habanero') }
commit(rose, 'spicier kind of chile')
edit(joel) { |s| s.sub('tortilla', 'potato') }
potato = commit(joel, 'potato chips. No one can eat just one.')
git(rose, 'push')
check(git(joel, 'push', success: false).include?('rejected'), 'divergent push is rejected')
before_fetch = text(joel)
git(joel, 'fetch', 'origin')
check(text(joel) == before_fetch, 'fetch leaves working files unchanged')
git(joel, 'merge', '--no-commit', 'origin/main')
check(text(joel).include?('habanero') && text(joel).include?('potato'), 'team merge combines both changes')
commit(joel, 'merge')
git(joel, 'push')
git(rose, 'fetch', 'origin')
git(rose, 'merge', '--ff-only', 'origin/main')

original = text(joel)
edit(joel) { |s| s.sub('Smoosh', 'Ooshsmay') }
git(joel, 'restore', 'guac')
check(text(joel) == original, 'restore discards the unstaged mistake')
edit(joel) { |s| s.sub('Smoosh', 'Ooshsmay') }
git(joel, 'add', 'guac')
git(joel, 'restore', '--staged', 'guac')
check(git(joel, 'diff', '--staged').empty? && text(joel).include?('Ooshsmay'), 'unstaging preserves working changes')
commit(joel, 'Pig Latin')
git(joel, 'reset', '--mixed', 'HEAD~1')
check(git(joel, 'status', '--short').include?(' M guac'), 'mixed reset retains the edit unstaged')
git(joel, 'restore', 'guac')
experiment = File.join(ROOT, 'experiment')
git(ROOT, 'clone', joel, experiment)
identity(experiment)
edit(experiment) { |s| s + "\nThis recipe is really good served with QUESO.\n\nQUESO is Spanish for \"cheese,\" but in Texas,\nit's just Kraft Slices melted in the microwave\nwith some salsa from a jar. MMM!\n" }
queso = commit(experiment, 'Queso = Cheese!')
git(experiment, 'push', 'origin', 'HEAD:refs/heads/queso')
check(text(joel) == original, 'push to queso does not modify checked-out main')
git(joel, 'merge', '--ff-only', 'queso')
git(experiment, 'remote', 'add', 'central', central)
git(experiment, 'fetch', 'central')
git(experiment, 'push', 'central', 'HEAD:main')
git(joel, 'fetch', 'origin')
check(git(joel, 'log', 'origin/main..HEAD').empty?, 'same experiment commit shared through central is not duplicated')
check(git(joel, 'revert', '--no-commit', potato, success: false).include?('CONFLICT'), 'old revert conflicts with the adjacent Queso addition')
File.write(File.join(joel, 'guac'), git(joel, 'show', 'HEAD:guac').sub('Serve with potato chips.', 'Serve with tortilla chips.'))
git(joel, 'add', 'guac')
check(text(joel).include?('tortilla') && text(joel).include?('QUESO'), 'old potato revert preserves later Queso')
commit(joel, 'undo thing from the past')
git(joel, 'push')

git(rose, 'fetch', 'origin')
git(rose, 'merge', '--ff-only', 'origin/main')
edit(rose) { |s| s.sub('2 ripe avocados', '2 ripe Hass avocados (not Haas)') }
commit(rose, 'better avocados')
git(rose, 'push')
edit(joel) { |s| s.sub('habanero', 'jalapeno') }
commit(joel, 'better chile')
git(joel, 'push', success: false)
git(joel, 'fetch', 'origin')
git(joel, 'merge', '--no-commit', 'origin/main')
commit(joel, 'merge')
git(joel, 'push')
git(rose, 'fetch', 'origin')
git(rose, 'merge', '--ff-only', 'origin/main')
edit(joel) { |s| s.sub("\n\nSmoosh", "\n* 1 delicious, yellow BANANA.\n\nSmoosh") }
commit(joel, 'bananas YUM')
git(joel, 'push')
edit(rose) { |s| s.sub("\n\nSmoosh", "\n* 1 ripe young Mango, in season.\n\nSmoosh") }
commit(rose, 'mmmmango')
git(rose, 'fetch', 'origin')
check(git(rose, 'merge', '--no-commit', 'origin/main', success: false).include?('CONFLICT'), 'banana and mango edits conflict')
edit(rose) { |s| s.sub(/<<<<<<< HEAD\n(.*?)=======\n(.*?)>>>>>>> origin\/main\n/m) { "#{$1}#{$2}" } }
commit(rose, 'merge')
git(rose, 'push')
git(joel, 'fetch', 'origin')
git(joel, 'merge', '--ff-only', 'origin/main')
release = git(joel, 'rev-parse', 'HEAD').strip
git(joel, 'tag', '-a', 'Version-1.0', '-m', 'Guacamole 1.0')
check(git(joel, 'rev-parse', 'HEAD').strip == release, 'annotated tag does not create a commit')
git(joel, 'push', 'origin', 'Version-1.0')
edit(joel) { |s| "GUACAMOLE 2.0 THIS IS GOING TO BE AWESOME\n\n" + s.sub('2 ripe', '200 ripe') }
commit(joel, 'more avocado flavor')
git(joel, 'switch', '-c', 'release/1.x', 'Version-1.0')
edit(joel) { |s| s.sub('1/2 teaspoon coarse salt', '1 grain table salt, split in half') }
fix = commit(joel, 'less salt')
git(joel, 'tag', '-a', 'Version-1.1', '-m', 'Guacamole 1.1: less salt')
git(joel, 'switch', 'main')
git(joel, 'merge', '--no-commit', 'release/1.x')
commit(joel, 'bringing in salt fix from 1.1')
check(text(joel).include?('200 ripe') && text(joel).include?('1 grain'), 'release fix merges into ongoing development')
check(git(joel, 'rev-parse', 'Version-1.0^{}').strip == release && git(joel, 'rev-parse', 'Version-1.1^{}').strip == fix, 'both release tags remain fixed')
stable = File.join(ROOT, 'recipes-stable')
dev = File.join(ROOT, 'recipes-dev')
git(ROOT, 'clone', '--no-tags', joel, stable)
git(stable, 'fetch', 'origin', 'tag', 'Version-1.0')
git(stable, 'switch', '-c', 'stable', 'Version-1.0')
identity(stable)
git(ROOT, 'clone', '--branch', 'stable', stable, dev)
git(dev, 'branch', '-m', 'dev')
identity(dev)
check(git(stable, 'tag', '--list').strip == 'Version-1.0', 'replay excludes first exercise Version-1.1 tag')
edit(dev) { |s| "GUACAMOLE 2.0 THIS IS GOING TO BE AWESOME\n\n" + s.sub('2 ripe', '200 ripe') }
commit(dev, 'more avocado flavor')
edit(stable) { |s| s.sub('1/2 teaspoon coarse salt', '1 grain table salt, split in half') }
commit(stable, 'less salt')
git(stable, 'tag', '-a', 'Version-1.1', '-m', 'Guacamole 1.1: less salt')
git(dev, 'fetch', 'origin')
git(dev, 'merge', '--no-commit', 'origin/stable')
commit(dev, 'merge')
check(text(dev).include?('200 ripe') && text(dev).include?('1 grain') && !text(stable).include?('200 ripe'), 'stable stays on release work while dev incorporates its fix')
check(git(dev, 'tag', '--list').lines.map(&:strip).sort == ['Version-1.0','Version-1.1'], 'fetch imports reachable release tag into dev')
puts 'Recipe workflow complete.'
