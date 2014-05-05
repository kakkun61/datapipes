class Datapipes
  # Tube takes effect data which passes through pipe.
  #
  # Build your own tube logic in `run` method.
  class Tube
    include Composable

    def run_all(data)
      @accumulated ||= [self]

      @accumulated.reduce(data) do |d, tube|
        if tube.accept? d
          tube.run(d)
        else
          d
        end
      end
    end

    def accept?(data)
      true
    end
  end
end
