require File.expand_path('lib/retry_anything.rb')

describe RetryAnything do
  let(:blows_up) { BlowsUp.new }

  describe 'when the operation does not throw an exception'
    it 'should return the result of the block when there are no exceptions' do
      result = RetryAnything.perform(RuntimeError) { 1 }

      result.should == 1
    end

  describe 'when the operation throws an exception the first time, then works' do
    it 'should try to do the wrapped operation again if it throws an exception the first time' do
      result = RetryAnything.perform(RuntimeError) { blows_up.once }

      result.should == 2
    end

    it 'should allow an exception we are not looking for to be raised' do
      lambda { RetryAnything.perform(NoMethodError) { blows_up.once } }.should raise_error RuntimeError, 'Oh no!'
    end
  end

  describe 'when the operation throws two exceptions, then works' do
    it 'should raise the same exception when only 1 retry is specified' do
      lambda { RetryAnything.perform(RuntimeError, :retries => 1) { blows_up.twice } }.should raise_error RuntimeError, 'Oh no!'
    end

    it 'should use the given retry count to keep trying' do
      result = RetryAnything.perform(RuntimeError, :retries => 2) { blows_up.twice }

      result.should == 3
    end

    it 'should trigger the :callback closure once for each retry' do
      class TestLogger; end

      logger = TestLogger.new
      logger.should_receive(:error).with('Failed').twice

      result = RetryAnything.perform(
        RuntimeError,
        :retries  => 2,
        :callback => lambda { logger.error('Failed') }
      ) { blows_up.twice }
    end
  end
end

class BlowsUp
  def once
    @index ||= 0
    @index += 1

    raise RuntimeError.new('Oh no!') if @index <= 1

    @index
  end

  def twice
    @index ||= 0
    @index += 1

    raise RuntimeError.new('Oh no!') if @index <= 2

    @index
  end
end
