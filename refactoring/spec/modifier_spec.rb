require_relative 'spec_helper'
require 'modifier'
require 'spec/support/spec_helpers/fixtures'
require 'pry'

describe Modifier do
  include SpecHelpers::Fixtures
  let(:tmp_dir) { File.expand_path('../tmp', File.dirname(__FILE__)) }
  let(:report_path) { fixture_path('report.csv') }

  let(:modified_path) { "#{ tmp_dir }/modified.csv" }
  let(:modified_output) { CSV.read "#{ modified_path }_0.txt", headers: true }
  let(:reference_modified_output) { CSV.read fixture_path('report.csv_0.txt.reference'), headers: true }

  let(:sorted_output) { CSV.read "#{ report_path }.sorted", headers: true }
  let(:reference_sorted_output) { CSV.read fixture_path('report.csv.sorted.reference'), headers: true }


  it "works" do
    modification_factor = 1
    cancellaction_factor = 0.4
    modifier = Modifier.new(modification_factor, cancellaction_factor)
    modifier.modify(modified_path, report_path)

    expect(sorted_output).to eq reference_sorted_output
    expect(modified_output).to eq reference_modified_output
  end

  describe 'performance_report' do
    it "sorts input data" do
      described_class.performance_report(
        input: report_path,
        output: modified_path,
        sales_factor: 1,
        cancellation_factor: 0.4,
      )

      expect(sorted_output).to eq reference_sorted_output
      expect(modified_output).to eq reference_modified_output
    end
  end
end
