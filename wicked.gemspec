# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wicked}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jacob Stetser"]
  s.date = %q{2009-02-01}
  s.description = %q{Wicked Good extensions to Object in the vein of #andand}
  s.email = %q{jake@wideopenspac.es}
  s.files = ["VERSION.yml", "lib/wicked.rb", "test/test_helper.rb", "test/wicked_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/wideopenspaces/wicked}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Wicked Good extensions to Object in the vein of #andand}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<andand>, [">= 1.3.1"])
    else
      s.add_dependency(%q<andand>, [">= 1.3.1"])
    end
  else
    s.add_dependency(%q<andand>, [">= 1.3.1"])
  end
end
