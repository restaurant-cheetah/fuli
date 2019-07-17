# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(Fuli) do
  let!(:logger_mock) { double("Mocked.logger").as_null_object }
  let(:warn_proc) { proc { |error, message| } }
  let(:error_proc) { proc { |error, message| } }

  before do
    allow(logger_mock).to receive(:warn).and_return(true)
    allow(logger_mock).to receive(:error).and_return(true)
  end

  let!(:config) do
    Fuli.configure do |config|
      config.logger = logger_mock
      config.warn_notifiers = [warn_proc]
      config.error_notifiers = [error_proc]
    end
  end

  describe '.notify_warning' do
    let(:error) { StandardError.new('Error message') }
    let(:message) { 'More specific message' }

    after { Fuli.notify_warning(error, message) }

    it 'calls logger with correct level' do
      expect(logger_mock).to receive(:warn)
    end

    it 'calls warn notifiers' do
      expect(warn_proc).to receive(:call).with(error, message)
    end
  end

  describe '.notify_error' do
    let(:error) { StandardError.new('Error message') }
    let(:message) { 'More specific message' }

    after { Fuli.notify_error(error, message) }

    it 'calls logger with correct level' do
      expect(logger_mock).to receive(:error)
    end

    it 'calls warn notifiers' do
      expect(error_proc).to receive(:call).with(error, message)
    end
  end
end
