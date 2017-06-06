# frozen_string_literal: true

require_relative 'puttext-rails/railtie' if defined?(Rails)

module PutText
  module Rails
    MSG_CONTEXT = 'Validation error'.freeze
  end
end
