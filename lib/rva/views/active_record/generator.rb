require 'active_support/inflector'

module Rva
  module ActiveRecord
    class Generator < Rva::ErbGenerator
      def template_dir
        File.expand_path(File.dirname(__FILE__))
      end

      def generate(data)
        templates = {
          class: erb("class.rb.erb"),
          migration: erb("migration.rb.erb")
        }
        gen_models(templates, [], data['models'])
      end

      private

      def gen_models(templates, ns, models)
        models.map do |model, data|
          if data['attributes']
            rec = {'name' => model, 'data' => data}
            puts gen_template(templates[:class], ns, rec)
            if options[:migration]
              puts gen_template(templates[:migration], ns, rec)
            end
          else
            gen_models(templates, ns + [model], data['children'])
          end
        end
      end

      def gen_template(template, ns, model)
        full_ns = (ns + [model['name']]).join('_')
        col_opts = ::Hash.new {|h, k| h[k] = ''}
        model['data']['attributes'].each do |name, data|
          if data['required']
            col_opts[name] << ", required: true"
          end
          if data.has_key?('default')
            d = if data['default'].is_a?(String)
                  "\"#{data['default']}\""
                else
                  data['default'].to_s
                end
            col_opts[name] << ", default: #{d}"
          end
        end
        template.result(binding)
      end
    end
  end
end
