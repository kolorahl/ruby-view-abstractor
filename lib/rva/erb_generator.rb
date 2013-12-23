require 'erb'

module Rva
  class ErbGenerator < Rva::Generator
    # Returns the root directory path for the ERB templates.
    #
    # @return [String] root directory path for the ERB templates.
    def template_dir
      throw "Method Not Implemented"
    end

    # Returns an ERB object given a template file.
    #
    # @param file [String] file path relative to {#template_dir}.
    #
    # @return [ERB] an ERB object ready to generate output.
    def erb(file)
      tmpl = ERB.new(File.read("#{template_dir}/#{file}"))
      tmpl.filename = file
      tmpl
    end
  end
end
