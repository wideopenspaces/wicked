$:.unshift File.dirname(__FILE__)

gem 'andand'
require 'andand'

module Wicked
  # Got it? Wicked Good!
  module Good
    
    # Aliases for 'andand'
    #     if phone = user.et.number; .... ; end
    alias_method :et, :andand       # Latin for 'and'
    
    # Alias for andand that's meaningful when checking booleans; 
    # this is the positive version of aint.
    #     "don't fix it" unless it.is.broken?
    # Returns nil if 'it' is broken, so this is safer than:
    #     "don't fix it" unless it.broken?
    alias_method :is, :andand       
    
    # Guarded method negation in the style of andand
    # Returns the logical opposite of the method invoked on the receiver
    #    receiver.aint.method
    # Traps NoMethodError and returns nil if receiver is nil 
    # or the method does not exist on the receiver. 
    #
    #     [].aint.empty?
    #     => false
    #     [].aint.nil?
    #     => true
    #     it.aint.broken?
    #     => false
    #
    # Don't be a doofus, use this wisely, on boolean methods only
    # if you know what's good for you.

    def aint (p = nil)
      NotReturningMe.new(self) 
    end
    
    # A few stylistic variations on aint
    alias_method :isnt, :aint
    alias_method :is_not, :aint
    alias_method :notnot, :aint
    
    # Hehe
    alias_method :aintnot, :is
  end
  
end

class Object
  include Wicked::Good
end

unless Module.constants.include?('BlankSlate')
  if Module.constants.include?('BasicObject')
    module Wicked
      class BlankSlate < BasicObject
      end
    end
  else
    module Wicked
      class BlankSlate
        def self.wipe
          instance_methods.reject { |m| m =~ /^__/ }.each { |m| undef_method m }
        end
        def initialize
          BlankSlate.wipe
        end
      end
    end
  end
end

module Wicked
  
  # A proxy that returns the opposite of whatever you ask it.
  class NotReturningMe < BlankSlate
    def initialize(me)
      super()
      @me = me
    end
    
    def method_missing(sym, *args, &block)
      begin
        !@me.__send__(sym, *args, &block)
      rescue NoMethodError
        nil
      end
    end
  end
end