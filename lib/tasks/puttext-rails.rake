# frozen_string_literal: true

require 'puttext-rails/extractor'

namespace :puttext do
  desc 'Extract strings from source to config/locales/template.pot' do
    PutText::Rails::Extractor.new.extract
  end
end
