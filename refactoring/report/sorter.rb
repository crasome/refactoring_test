require 'csv'

module Report
  class Sorter

    def initialize(csv_table)
      @csv_table = csv_table
    end

    def sort(header_col)
      headers = csv_table.headers
      index_of_key = headers.index(header_col)
      content = csv_table.sort_by { |a| -a[index_of_key].to_i }
      return CSV::Table.new content
    end

    private
    attr_reader :csv_table
  end
end
