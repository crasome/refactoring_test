require_relative '../spec_helper'
require 'report/sorter'
require 'spec/support/spec_helpers/fixtures'
require 'pry'

describe Report::Sorter do
  include SpecHelpers::Fixtures

  subject { described_class.new input_table }

  let(:input_table) { to_csv_table [
    ['ID', 'Clicks'],
    [1,    1],
    [2,    40],
    [3,    10],
  ] }

  let(:sorted_table) { to_csv_table [
    ['ID', 'Clicks'],
    [2,    40],
    [3,    10],
    [1,    1],
  ] }

  it "sorts report data in DESC order" do
    expect(subject.sort('Clicks').to_a).to eq sorted_table.to_a
  end

  private
  def to_csv_table(array)
    headers = array.first
    CSV::Table.new(
      array.map do |row|
        CSV::Row.new headers, row, row == headers
      end
    )
  end
end
