# frozen_string_literal: true

module Fuli
  Error = Class.new(StandardError)

  class << self
    attr_writer :config

    def logger
      @config.logger
    end

    def notify_warning(error, context_message = nil)
      log(error, level: :warn) do
        @config.warn_notifiers&.map { |notifier| notifier.call(error, context_message) }
      end
    end

    def notify_error(error, context_message = nil)
      log(error, level: :error) do
        @config.error_notifiers&.map { |notifier| notifier.call(error, context_message) }
      end
    end

    def log(message_or_error, level: :info)
      yield if block_given?
      logger.public_send(level, message_or_error)
    end

    def configure
      yield @config = Fuli::Config.instance if block_given?
    end
  end
end
