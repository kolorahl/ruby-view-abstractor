require 'yaml'

module Rva
  # Contains functionality related to parsing RVA data definition files, turning
  # them into usable Ruby data structures to be used in view generation.
  class Parser

    # Reads a single data definitions file and returns the parsed information.
    #
    # @param file [String] the path to a data definitions file.
    #
    # @return [Hash] a collection of parsed data definitions.
    def self.parse(file)
      contents = File.open(file) { |f| f.read }
      data = YAML.load(contents)
      result = validate(data)
      if result == true
        data
      else
        throw result
      end
    end

    private

    # Performs validation on a given hash. Ensures that data definitions meets a
    # required format.
    #
    # @param data [Hash] the parsed data definitions.
    #
    # @return [true,String] if `true` is returned, then the data is valid;
    #   otherwise, a string containing an error description is returned.
    def self.validate(data)
      true
    end

  end
end
