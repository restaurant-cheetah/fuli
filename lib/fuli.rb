# frozen_string_literal: true

module Fuli
  Error = Class.new(StandardError)

  class << self
    attr_writer :config

    # Logs warn level and calls warn notifiers.
    #
    # Example:
    #   class Cheetah
    #     def hunt
    #       # do things
    #     rescue => e
    #       Fuli.notify_warning(e, key: :value)
    #     end
    #   end
    # Arguments:
    #   object: Object that responds to to_s method
    #   object: Object that responds to inspect method
    def notify_warning(error, context_message = nil)
      log(error, level: :warn) do
        @config.warn_notifiers&.map { |notifier| notifier.call(error, context_message) }
      end
    end

    # Logs error level and calls error notifiers.
    #
    # Example:
    #   class Cheetah
    #     def hunt
    #       # do things
    #     rescue => e
    #       Fuli.notify_error(e, key: :value)
    #     end
    #   end
    # Arguments:
    #   object: Object that responds to to_s method
    #   object: Object that responds to inspect method
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
      raise Fuli::Error, 'logger is a mandatory configuration' unless @config.logger
    end

    private

    def logger
      @config.logger
    end
  end
end
