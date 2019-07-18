# fuli
Respond to application errors with configurable notifiers

[![Gem Version](https://badge.fury.io/rb/fuli_the_guard.svg)](https://badge.fury.io/rb/fuli_the_guard)

### Install

```ruby
gem install fuli_the_guard
```

### Configuration

```ruby
# Notifier could be any callable object that gets error param
Fuli.configure do |config|
  config.logger = YourLogger
  config.warn_notifiers = [
    ->(error, message){ do_something_with(error, message) }]
  config.error_notifiers = [
    proc { |error, message| do_something_with(error, message) }]
end

# Or using class instead of proc / lambda
class SomeNotifier
  class << self
    def call(error, message)
      # notify some service
    end
  end
end

Fuli.configure do |config|
  config.logger = YourLogger
  config.warn_notifiers = [SomeNotifier]
end
```

### Example

```ruby
class Cheetah
  def hunt_em
    # do things
  rescue => e
    context_message = { custom: 'context', more: :things }
    Fuli.notify_error(e, context_message)
  end

  def follow_em
    # do more things
    warn_message = 'May be something gonna brake..'
    Fuli.notify_warning(warn_message)
  end
end
