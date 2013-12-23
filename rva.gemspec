Gem::Specification.new do |spec|
  spec.name        = 'rva'
  spec.version     = '0.0.1'
  spec.date        = '2013-12-16'
  spec.summary     = "Ruby View Abstractor"
  spec.description = "Further abstracts the definition of data from the automatic creation of 'views', be that actual view files, models, documentation, or whatever else you want."
  spec.authors     = ["Tyler Margison"]
  spec.email       = "kolorahl@gmail.com"
  spec.files       = Dir.glob("#{Dir.pwd}/**/*")
  spec.homepage    = "http://kolorahl.com/rva"
  spec.license     = "MIT"

  spec.add_runtime_dependency 'active_support', '>= 3.0.0'

  spec.requirements << "ActiveSupport 3.0.0 or greater (specifically Inflector)"
end
