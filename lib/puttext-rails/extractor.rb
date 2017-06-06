# frozen_string_literal: true

require 'puttext'
require 'rails'

module PutText
  module Rails
    class Extractor
      def extract
        puttext_extractor = PutText::Extractor.new
        po_file = puttext_extractor.extract(Rails.root.to_s)

        errors_file = extract_errors
        po_file.merge(errors_file)

        File.open(template_path, 'w') do |f|
          po_file.write_to(f)
        end
      end

      private

      def root_path
        Rails.root.relative_path_from(Pathname.new(Dir.pwd))
      end

      def template_path
        File.join(locales_path, 'template.pot')
      end

      def locales_path
        Rails.root.join('config/locales')
      end

      def extract_errors
        entries = i18n_error_messages.map do |_key, value|
          create_entry_from_translation(value)
        end

        POFile.new(entries)
      end

      def i18n_error_messages
        translations = I18n.backend.send(:translations)
        translations[I18n.default_locale][:errors][:messages]
      end

      def create_entry_from_translation(translation)
        case translation
        when String
          POEntry.new(msgctxt: 'errors', msgid: translation)
        when Hash
          POEntry.new(
            msgctxt: 'errors',
            msgid: translation[:one] || translation[:other],
            msgid_plural: translation[:other]
          )
        end
      end
    end
  end
end
