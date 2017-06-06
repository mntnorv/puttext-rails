# frozen_string_literal: true

require 'puttext-rails/extractor'

namespace :puttext do
  desc 'Extract strings from source to config/locales/template.pot'
  task extract: :environment do
    locales_path = ::Rails.root.join('config/locales')
    template_path = File.join(locales_path, 'template.pot')

    po_file = PutText::Rails::Extractor.new.extract

    File.open(template_path, 'w') do |f|
      po_file.write_to(f)
    end
  end
end
