# frozen_string_literal: true

require_relative './storage'
require_relative './read_value'
require_relative './../io_adapter'

module States
  class ReadSecondScale < Storage
    def execute
      IOAdapter.instance.write('Please, enter second convertation scale(C, F, K)')
    end

    def next
      @scale = IOAdapter.instance.read.upcase
      exit if @scale == 'E'
      if SCALES.include?(@scale)
        it_familiar?
      else
        IOAdapter.instance.write("#{@scale} is not conversation scale")
        self
      end
    end

    def it_familiar?
      if @scale == context[:first_scale]
        IOAdapter.instance.write("Second scale must not be equal first one \"#{context[:first_scale]}\"")
        self
      else
        ReadValue.new(context.merge(second_scale: @scale))
      end
    end
  end
end
