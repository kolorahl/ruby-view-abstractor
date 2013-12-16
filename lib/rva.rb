require 'rva/parser'
require 'rva/generator'

module Rva
  class Builder
    attr_reader :data

    # Construct a builder object from one or more definition files.
    #
    # definitions: (String|Array) One or more path strings to definition files.
    #
    # returns: (Rva::Builder) Can be used with `Rva::Generator` implementations
    # to generate output based on the data parsed from `definitions`.
    def initialize(definitions)
      definitions = [definitions] unless definitions.is_a?(Array)
      @data = build_data({}, definitions)
    end

    # Runs the builder's parsed data definitions against a collection of view
    # generators.
    #
    # generators: (Array[Rva::Generator]) A collection of view generators
    # *classes*; they should not be actual instance objects, as this function
    # will handle constructing each instance with the proper data.
    # options: (Hash) A collection of options to pass to each generator. This
    # should conform to the specification for `Rva::Generator#initialize`.
    #
    # returns: (nil) The generators are all meant to work via side-effects,
    # therefore there is nothing to be returned.
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
    # hash: (Hash) The current state of the data hash.
    # defs: (Array) The remaining definition files to merge with `hash`.
    #
    # returns: (Hash) The merge of `hash` and all data definitions provided by
    # `defs`.
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
