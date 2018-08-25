# frozen_string_literal: true

module Command
  module Result
    class Error
      attr_reader :error
      def initialize(error)
        @error = error
      end

      def success?
        false
      end
    end
  end
end
