# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{uclassify}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Manish Chakravarty}]
  s.date = %q{2011-11-06}
  s.description = %q{A gem enabling you to create classsifers and use them using the UClassify API. www.uclassify.com/XmlApiDocumentation.aspx#examples}
  s.email = %q{manishchaks@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "lib/uclassify.rb",
    "lib/uclassify_class.rb",
    "lib/uclassify_classifier.rb",
    "lib/uclassify_create_id.rb",
    "lib/uclassify_query.rb",
    "lib/uclassify_request.rb",
    "lib/uclassify_response.rb",
    "lib/uclassify_text.rb",
    "lib/uclassify_training_class.rb",
    "lib/uclassify_utils.rb",
    "lib/uclassify_write_call.rb",
    "spec/spec_helper.rb",
    "spec/uclassify_class_spec.rb",
    "spec/uclassify_classifier_spec.rb",
    "spec/uclassify_create_id_spec.rb",
    "spec/uclassify_query_spec.rb",
    "spec/uclassify_spec.rb",
    "spec/uclassify_text_spec.rb",
    "spec/uclassify_training_class_spec.rb",
    "spec/uclassify_utils_spec.rb",
    "spec/uclassify_write_call_spec.rb",
    "test-helpers/xml_compare.rb"
  ]
  s.homepage = %q{http://github.com/manishchaks/uclassify}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{A Ruby gem for UClassify}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<httparty>, ["= 0.8.1"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<httparty>, ["= 0.8.1"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<httparty>, ["= 0.8.1"])
  end
end
