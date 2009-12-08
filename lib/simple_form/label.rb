module SimpleForm
  module Label

    private

      def generate_label
        return '' if @options[:label] == false
        html_options = { :class => "#{@input_type} #{required_class}".strip }
        label(@attribute, label_text, html_options)
      end

      def label_text
        required_text << (@options[:label] || translate_label)
      end

      def required_text
        attribute_required? ? translate_required_string : ''
      end

      def translate_label
        default = @object.try(:human_attribute_name, @attribute.to_s) || @attribute.to_s.humanize
        I18n.t(:"#{@object_name}.#{@attribute}", :scope => :"views.labels", :default => default)
      end

      def translate_required_string
        translate_string(:required_string, :default =>
          %[<abbr title="#{translate_required_text}">#{translate_required_mark}</abbr> ]
        )
      end

      def translate_required_text
        translate_string(:required_text, :default => 'required')
      end

      def translate_required_mark
        translate_string(:required_mark, :default => '*')
      end

      def translate_string(key, params={})
        I18n.t(key, {:scope => :simple_form}.merge!(params))
      end
  end
end