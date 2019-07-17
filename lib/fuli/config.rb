# frozen_string_literal: true

module Fuli
  class Config
    attr_accessor :logger, :warn_notifiers, :error_notifiers

    def initialize(config_hash = {})
      self.logger = config_hash[:logger]
      self.warn_notifiers = config_hash[:warn_notifiers]
      self.error_notifiers = config_hash[:error_notifiers]
      merge(config_hash)
    end

    class << self
      attr_writer :instance

      def instance
        @instance ||= new
      end
    end

    private

    def merge(config_hash)
      config_hash.each_pair(&method(:set_option))
      self
    end

    def set_option(option, value)
      __send__("#{option}=", value)
    rescue NoMethodError
      raise Fuli::Error, "unknown config option '#{option}'"
    end
  end
end
