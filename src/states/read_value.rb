# frozen_string_literal: true

require_relative './storage'
require_relative './calculate_value'
require_relative './../io_adapter'

module States
  class ReadValue < Storage
    def execute
      IOAdapter.instance.write('Please, enter convertation value')
    end

    def next
      value = IOAdapter.instance.read
      exit if value == 'E'
      if /-?[0-9]+/.match?(value)
        CalculateValue.new(context.merge(value: value))
      else
        IOAdapter.instance.write("#{value} is not correct value")
        self
      end
    end
  end
end
