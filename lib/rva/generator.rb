module Rva
  # The required base class for all view generators. Must implement the
  # "virtual" methods in this class, adhering to the contract specified, for any
  # subclass to be considered a valid view generator.
  class Generator

    # Constructs a new view generator.
    #
    # opts: (Hash) An optional set of generator options. Defaults to an empty
    # hash.
    #
    # examples
    #
    # opts:
    #   out: Path to the root output directory.
    #
    # returns: (Rva::Generator) A new instance of a view generator.
    def initialize(opts={})
      defaults = {
        out: Dir.pwd
      }
      @options = defaults.merge(opts).freeze
    end

    # Returns the options hash. A read-only copy is returned, though objects
    # within the hash may be modifiable still.
    #
    # returns: (Hash) Options set for the generator.
    def options
      @options
    end

    # Generate some output based on the given data definition hash.
    #
    # data: (Hash) A collection of data definitions. This is expected to be a
    # data structure formatted to the specification set forth by `Rva::Parser`.
    #
    # returns: (nil) This function should work using side-effects, actions that
    # affect systems and components outside of the function's stack. This means
    # creating or modifying files, generating console output, and so on.
    def generate(data)
      throw "Method Not Implemented"
    end

  end
end
