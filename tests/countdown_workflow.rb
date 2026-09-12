# Run with ruby tests/countdown_workflow.rb; no network or existing repo writes.
require 'tmpdir'
require 'open3'
ENV['GIT_CONFIG_GLOBAL'] = File::NULL
ENV['GIT_CONFIG_NOSYSTEM'] = '1'
ROOT = Dir.mktmpdir('gitinit-countdown-')
puts "Test repository: #{ROOT}"
def git(*args)
  out, err, status = Open3.capture3('git', '-C', ROOT, *args)
  raise "#{args.join(' ')}: #{out}#{err}" unless status.success?
  out
end
def check(value, message)
  raise message unless value
  puts "PASS: #{message}"
end
def write(name, value)
  File.write(File.join(ROOT, name), value)
end
def read(name)
  File.read(File.join(ROOT, name))
end
def commit(message)
  git('commit', '-m', message)
  git('rev-parse', 'HEAD').strip
end
initial = "Scott Adams: Normal people believe that if it ain't\nbroke, don't fix it. Engineers believe that if it\nain't broke, it doesn't have enough features yet.\n"
capital = initial.sub('Scott Adams', 'SCOTT ADAMS')
grammar = capital.gsub("ain't", "isn't").gsub('broke,', 'broken,')
git('init', '-b', 'main')
git('config', 'user.name', 'Tutorial Test')
git('config', 'user.email', 'tutorial@example.com')
write('a.txt', initial)
write('favicon.ico', 'icon fixture')
git('add', '.')
first = commit('Initial version of the CountDown code')
write('a.txt', capital)
git('add', 'a.txt')
second = commit('Capitalized Scott Adams')
write('a.txt', grammar)
git('add', 'a.txt')
commit('Fixed some grammar')
File.delete(File.join(ROOT, 'a.txt'))
git('restore', 'a.txt')
check(read('a.txt') == grammar, 'restore recovers a deleted tracked file')
write('a.txt', 'accidental edit')
git('restore', '.')
check(read('a.txt') == grammar, 'restore dot recovers committed contents when index is unchanged')
write('b.txt', grammar)
write('a.txt', grammar.sub('Normal people', 'Civilians'))
File.delete(File.join(ROOT, 'favicon.ico'))
check(git('status', '--short') == " M a.txt\n D favicon.ico\n?? b.txt\n", 'unstaged status matches chapter columns and order')
check(git('diff', 'a.txt').include?('+SCOTT ADAMS: Civilians'), 'diff shows the changed text')
git('rm', 'favicon.ico')
check(git('status', '--short') == " M a.txt\nD  favicon.ico\n?? b.txt\n", 'git rm stages the missing icon deletion')
git('add', '.')
check(git('status', '--short') == "M  a.txt\nA  b.txt\nD  favicon.ico\n", 'add dot stages modification, addition and deletion')
commit('A few highly meaningful changes. No favicon.ico no more.')
check(git('show', "#{first}:a.txt") == initial, 'show retrieves initial file contents by hash')
check(git('diff', first, second, '--', 'a.txt').include?('+SCOTT ADAMS:'), 'two-commit diff isolates capitalization')
git('switch', '--detach', first)
check(read('a.txt') == initial && File.exist?(File.join(ROOT,'favicon.ico')) && !File.exist?(File.join(ROOT,'b.txt')), 'detached switch restores historical files and removals')
git('switch', '--detach', second)
check(read('a.txt') == capital, 'switch to capitalization commit retrieves that version')
git('switch', 'main')
check(read('a.txt').include?('Civilians') && !File.exist?(File.join(ROOT,'favicon.ico')) && File.exist?(File.join(ROOT,'b.txt')), 'switch main restores latest snapshot')
check(git('status', '--short').empty?, 'walkthrough ends with clean main')
puts 'CountDown workflow complete.'
