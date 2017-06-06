# frozen_string_literal: true

require 'rails'

module PutText
  module Rails
    class Railtie < Rails::Railtie
      rake_tasks do
        load 'tasks/puttext-rails.rake'
      end
    end
  end
end
