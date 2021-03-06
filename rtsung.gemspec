# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rtsung}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Foy Savas"]
  s.date = %q{2009-06-29}
  s.email = %q{foysavas@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "lib/rtsung_template.xml.erb", "lib/rtsung.rb", "spec/rtsung_spec.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/foysavas/rtsung}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
