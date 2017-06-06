# frozen_string_literal: true

require 'puttext'
require 'rails'

module PutText
  module Rails
    class Extractor
      def extract
        puttext_extractor = PutText::Extractor.new
        po_file = puttext_extractor.extract(root_path)

        errors_file = extract_errors
        po_file.merge(errors_file)

        File.open(template_path, 'w') do |f|
          po_file.write_to(f)
        end
      end

      private

      def root_path
        ::Rails.root.relative_path_from(Pathname.new(Dir.pwd))
      end

      def template_path
        File.join(locales_path, 'template.pot')
      end

      def locales_path
        ::Rails.root.join('config/locales')
      end

      def extract_errors
        entries = i18n_error_messages.map do |_key, value|
          create_entry_from_translation(value)
        end

        POFile.new(entries)
      end

      def i18n_error_messages
        i18n_backend = I18n.backend

        unless i18n_backend.is_a? I18n::Backend::Simple
          raise 'only I18n::Backend::Simple is supported'
        end

        i18n_backend.available_locales # Force I18n to load translations

        translations = i18n_backend.send(:translations)
        translations.fetch(I18n.default_locale, {})
                    .fetch(:errors, {})
                    .fetch(:messages, {})
      end

      def create_entry_from_translation(translation)
        case translation
        when String
          POEntry.new(msgctxt: PutText::Rails::MSG_CONTEXT, msgid: translation)
        when Hash
          POEntry.new(
            msgctxt: PutText::Rails::MSG_CONTEXT,
            msgid: translation[:one] || translation[:other],
            msgid_plural: translation[:other]
          )
        end
      end
    end
  end
end
