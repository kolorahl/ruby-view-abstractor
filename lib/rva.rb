require 'rva/parser'
require 'rva/generator'
require 'rva/erb_generator'

module Rva
  class Builder
    attr_reader :data

    # Construct a builder object from one or more definition files.
    #
    # @param definitions [String,Array<String>] one or more strings representing
    #   file paths to data definitions.
    def initialize(definitions)
      definitions = [definitions] unless definitions.is_a?(Array)
      @data = build_data({}, definitions)
    end

    # Runs the builder's parsed data definitions against a collection of view
    # generators.
    #
    # @param generators [Array<Rva::Generator>] a collection of view generators
    #   *classes*; they should not be actual instance objects, as this function
    #   will handle constructing each instance with the proper data.
    # @param options [Hash] a collection of options to pass to each generator.
    #   See {Rva::Generator#initialize Rva::Generator#initialize} for details.
    #
    # @return [nil] the generators are all meant to work via side-effects,
    #   therefore there is nothing to be returned.
    def run(generators, options={})
      throw "Must pass an array to `Rva::Builder#run`" unless generators.is_a?(Array)
      generators.each do |gclass|
        if gclass < Rva::Generator
          generator = gclass.new(options)
          generator.generate(@data)
        else
          puts "Warning: Invalid generator class (#{gclass}) given, skipping..."
        end
      end
    end

    private

    # Creates a single hash of data from a collection of data definition files.
    #
    # @param hash [Hash] the current state of the data hash.
    # @param defs [Array<String>] the remaining definition files to process.
    #
    # @return [Hash] the merge of `hash` and all data definitions provided by
    #   `defs`.
    def build_data(hash, defs)
      current = defs.shift
      data = if current.is_a?(Array)
               build_data(hash, current)
             elsif current.is_a?(String)
               Parser.parse(current)
             end
      return hash unless data
      build_data(hash.merge(data), defs)
    end
  end
end
