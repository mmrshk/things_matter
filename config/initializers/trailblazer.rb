# frozen_string_literal: true

require 'reform'
require 'reform/form/dry'
require 'reform/form/coercion'

Dir[Rails.root.join('lib', 'macro', '**', '*.rb')].sort.each { |file| require file }
