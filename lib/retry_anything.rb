class RetryAnything

  # Public: Wrap an operation that may throw an exception, trying
  # the operation one or more times if the given exceptions occur.
  #
  # Example:
  #
  #   RetryAnything.perform([Timeout::Error, RuntimeError], :retries => 3) do
  #     Net::Http.post
  #   end
  #
  # exceptions - An Array or Single exception class to watch for
  #
  # options    - Optional parameters:
  #              :callback - Optional. A closure that responds to #call
  #                          that will be triggered when the operation
  #                          is retried. Probably should be a lambda so
  #                          the callback can't return from #perform.
  #              :retries  - How many attempts to make before giving up.
  #
  def self.perform(exceptions, options = {}, &block)
    retries = options[:retries] || 1

    begin
      yield
    rescue exceptions => e
      raise if retries <= 0
      retries -= 1

      # Allow some processing before trying again (logging?)
      callback = options[:callback]
      callback && callback.call

      retry
    end
  end

end
