# frozen_string_literal: true

require_relative './storage'
require_relative './read_second_scale'
require_relative './../io_adapter'

module States
  class ReadFirstScale < Storage
    def execute
      IOAdapter.instance.write('Please, enter first convertation scale(C, F, K)')
    end

    def next
      scale = IOAdapter.instance.read.upcase
      exit if scale == 'E'
      if SCALES.include?(scale)
        ReadSecondScale.new(context.merge(first_scale: scale))
      else
        IOAdapter.instance.write("#{scale} is not conversation scale")
        self
      end
    end
  end
end
