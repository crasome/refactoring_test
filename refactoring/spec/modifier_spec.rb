require_relative 'spec_helper'
require 'modifier'
require 'spec/support/spec_helpers/fixtures'
require 'pry'

describe Modifier do
  include SpecHelpers::Fixtures

  it "works" do
    modified = input = fixture_path('report.csv')
    modification_factor = 1
    cancellaction_factor = 0.4
    modifier = Modifier.new(modification_factor, cancellaction_factor)
    modifier.modify(modified, input)

    puts "DONE modifying"
  end
end
