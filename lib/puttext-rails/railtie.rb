# frozen_string_literal: true

module PutText
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load 'tasks/puttext-rails.rake'
      end
    end
  end
end
