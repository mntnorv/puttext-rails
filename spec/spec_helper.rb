# frozen_string_literal: true

require 'simplecov'
require 'timecop'
require 'unindent'

SimpleCov.start do
  add_filter '/spec/'
end

require 'puttext-rails'
