require 'csv'
require 'report/sorter'
require 'report/modifier'

class PerformanceReport
  DEFAULT_CSV_OPTIONS = { :col_sep => "\t", :headers => :first_row }

  def initialize(input:, output:)
    @input = input
    @output = output
  end

  def generate(sales_factor:, cancellation_factor:)
    csv_table = csv_lazy_read input

    sorted_report = Report::Sorter.new(csv_table).sort 'Clicks'
    sorted_report_path = "#{input}.sorted"

    write sorted_report_path, sorted_report

    modifier = Report::Modifier.new(sales_factor, cancellation_factor)
    modifier.modify output, sorted_report
  end


  private
  attr_reader :input, :output

  def csv_lazy_read(input, options: DEFAULT_CSV_OPTIONS)
    CSV.read input, options
  end

  def write(output, csv_table, options: DEFAULT_CSV_OPTIONS)
    File.open(output, 'w:UTF-8') { |file| file.write(csv_table.to_csv options)}
  end
end
