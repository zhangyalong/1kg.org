module Spec
  module Matchers
    
    #Based on patch from Wilson Bilkovich
    class Change #:nodoc:
      def initialize(receiver=nil, message=nil, &block)
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
        @message = message || "result"
        @value_proc = block || lambda {
          receiver.__send__(message)
        }
      end
      
      def matches?(event_proc)
        raise_block_syntax_error if block_given?
        
        @before = evaluate_value_proc
        event_proc.call
        @after = evaluate_value_proc
        
        return false if @from unless @from == @before
        return false if @to unless @to == @after
=======
=======
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
        @receiver = receiver
        @message = message
        @block = block
      end
      
      def matches?(target, &block)
        if block
          raise MatcherError.new(<<-EOF
block passed to should or should_not change must use {} instead of do/end
EOF
)
        end
        @target = target
        execute_change
        return false if @from && (@from != @before)
        return false if @to && (@to != @after)
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
=======
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
        return (@before + @amount == @after) if @amount
        return ((@after - @before) >= @minimum) if @minimum
        return ((@after - @before) <= @maximum) if @maximum        
        return @before != @after
      end
      
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
      def raise_block_syntax_error
        raise MatcherError.new(<<-MESSAGE
block passed to should or should_not change must use {} instead of do/end
MESSAGE
        )
      end
      
      def evaluate_value_proc
        @value_proc.call
=======
=======
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
      def execute_change
        @before = @block.nil? ? @receiver.__send__(@message) : @block.call
        @target.call
        @after = @block.nil? ? @receiver.__send__(@message) : @block.call
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
=======
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
      end
      
      def failure_message
        if @to
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
          "#{@message} should have been changed to #{@to.inspect}, but is now #{@after.inspect}"
        elsif @from
          "#{@message} should have initially been #{@from.inspect}, but was #{@before.inspect}"
        elsif @amount
          "#{@message} should have been changed by #{@amount.inspect}, but was changed by #{actual_delta.inspect}"
        elsif @minimum
          "#{@message} should have been changed by at least #{@minimum.inspect}, but was changed by #{actual_delta.inspect}"
        elsif @maximum
          "#{@message} should have been changed by at most #{@maximum.inspect}, but was changed by #{actual_delta.inspect}"
        else
          "#{@message} should have changed, but is still #{@before.inspect}"
        end
      end
      
=======
=======
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
          "#{result} should have been changed to #{@to.inspect}, but is now #{@after.inspect}"
        elsif @from
          "#{result} should have initially been #{@from.inspect}, but was #{@before.inspect}"
        elsif @amount
          "#{result} should have been changed by #{@amount.inspect}, but was changed by #{actual_delta.inspect}"
        elsif @minimum
          "#{result} should have been changed by at least #{@minimum.inspect}, but was changed by #{actual_delta.inspect}"
        elsif @maximum
          "#{result} should have been changed by at most #{@maximum.inspect}, but was changed by #{actual_delta.inspect}"
        else
          "#{result} should have changed, but is still #{@before.inspect}"
        end
      end
      
      def result
        @message || "result"
      end
      
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
=======
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
      def actual_delta
        @after - @before
      end
      
      def negative_failure_message
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
        "#{@message} should not have changed, but did change from #{@before.inspect} to #{@after.inspect}"
=======
        "#{result} should not have changed, but did change from #{@before.inspect} to #{@after.inspect}"
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
=======
        "#{result} should not have changed, but did change from #{@before.inspect} to #{@after.inspect}"
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
      end
      
      def by(amount)
        @amount = amount
        self
      end
      
      def by_at_least(minimum)
        @minimum = minimum
        self
      end
      
      def by_at_most(maximum)
        @maximum = maximum
        self
      end      
      
      def to(to)
        @to = to
        self
      end
      
      def from (from)
        @from = from
        self
      end
    end
    
    # :call-seq:
    #   should change(receiver, message, &block)
    #   should change(receiver, message, &block).by(value)
    #   should change(receiver, message, &block).from(old).to(new)
    #   should_not change(receiver, message, &block)
    #
    # Allows you to specify that a Proc will cause some value to change.
    #
    # == Examples
    #
    #   lambda {
    #     team.add_player(player) 
    #   }.should change(roster, :count)
    #
    #   lambda {
    #     team.add_player(player) 
    #   }.should change(roster, :count).by(1)
    #
    #   lambda {
    #     team.add_player(player) 
    #   }.should change(roster, :count).by_at_least(1)
    #
    #   lambda {
    #     team.add_player(player)
    #   }.should change(roster, :count).by_at_most(1)    
    #
    #   string = "string"
    #   lambda {
    #     string.reverse!
    #   }.should change { string }.from("string").to("gnirts")
    #
    #   lambda {
    #     person.happy_birthday
    #   }.should change(person, :birthday).from(32).to(33)
    #       
    #   lambda {
    #     employee.develop_great_new_social_networking_app
    #   }.should change(employee, :title).from("Mail Clerk").to("CEO")
    #
    # Evaluates <tt>receiver.message</tt> or <tt>block</tt> before and after
    # it evaluates the c object (generated by the lambdas in the examples
    # above).
    #
    # Then compares the values before and after the <tt>receiver.message</tt>
    # and evaluates the difference compared to the expected difference.
    #
    # == WARNING
    # <tt>should_not change</tt> only supports the form with no
    # subsequent calls to <tt>by</tt>, <tt>by_at_least</tt>,
    # <tt>by_at_most</tt>, <tt>to</tt> or <tt>from</tt>.
    #
    # blocks passed to <tt>should</tt> <tt>change</tt> and <tt>should_not</tt>
    # <tt>change</tt> must use the <tt>{}</tt> form (<tt>do/end</tt> is not
    # supported).
    #
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
<<<<<<< HEAD:vendor/plugins/rspec/lib/spec/matchers/change.rb
    def change(receiver=nil, message=nil, &block)
      Matchers::Change.new(receiver, message, &block)
=======
    def change(target=nil, message=nil, &block)
      Matchers::Change.new(target, message, &block)
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
=======
    def change(target=nil, message=nil, &block)
      Matchers::Change.new(target, message, &block)
>>>>>>> c0ecd1809fb41614ff2905f5c6250ede5f190a92:vendor/plugins/rspec/lib/spec/matchers/change.rb
    end
  end
end
