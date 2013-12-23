require 'active_support/inflector'

module Rva
  module ActiveModel
    class Generator < Rva::ErbGenerator
      def template_dir
        File.expand_path(File.dirname(__FILE__))
      end

      def generate(data)
        gen_models(erb("class.rb.erb"), [], data['models'])
      end

      private

      def gen_models(template, ns, models)
        models.map do |model, data|
          if data['attributes']
            gen_model(template, ns, {'name' => model, 'data' => data})
          else
            gen_models(template, ns + [model], data['children'])
          end
        end
      end

      def gen_model(template, ns, model)
        includes = ['Model']
        includes << 'Dirty' if options['dirty']
        includes << 'Naming' if options['naming']
        if s = options['serialize']
          if s =='json'
            includes << 'Serializers::JSON'
          elsif s == 'xml'
            includes << 'Serializers::Xml'
          end
        end
        if options['translate']
          includes << 'Translation'
        end
        template.result(binding)
      end
    end
  end
end
