Gem::Specification.new do |s|
  s.name        = 'gear'
  s.version     = '0.0.1'
  s.license     = 'GPL-3'
  s.summary     = 'modular dependency build system for native extensions'
  s.description = 'gear provides a modular framework to encapsulate build tasks for native ' + 
                    'extension dependencies.'
  s.authors     = ['Rei Kagetsuki']
  s.email       = 'zero@genshin.org'
  s.files       = ['gear.gemspec'] +
                  Dir.glob("lib")
  s.require_path = 'lib'
  s.homepage    = 'https://github.com/Kagetsuki/gear'

  s.add_dependency 'git'
end
