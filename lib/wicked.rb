$:.unshift File.dirname(__FILE__)

gem 'andand'
require 'andand'

module Wicked
  # Got it? Wicked Good!
  module Good
    
    # Alias for 'andand' that reads like 'if user and number' 
    #     if user.et.number...
    alias_method :et, :andand       # Latin for 'and'

    # Alias for 'andand' that reads like 'if user, ask its number' 
    #     if user.ask.number...
    alias_method :ask, :andand
    
    # Alias for andand that's meaningful when checking booleans; 
    # this is the positive version of aint.
    #     "don't fix it" unless it.is.broken?
    alias_method :is, :andand  
    
    # :nodoc:
    alias_method :aintnot, :andand   
    
    # Guarded method negation in the style of andand
    # Returns the logical opposite of the method invoked on the receiver
    # Returns nil if receiver is nil or doesn't have method. 
    #
    #     [].aint.empty?  => false
    #     [].aint.nil?    => true
    #     it.aint.broken? => false
    #
    # Don't be a doofus, use this wisely, on boolean methods only if you know what's good for you.
    def aint(p = nil)
      NotReturningMe.new(self) 
    end
    
    # A funny byproduct of using aint...
    # nil.aint_nothin? => false
    def aint_nothin?
      self.aint.nil?
    end
    alias_method :aint_it_somethin?, :aint_nothin?
    
    # nil.is_nothin? => true
    def is_nothin?
      !self.is.nil?
    end
    
    # A few stylistic variations on aint for the grammatically uncreative ;)
    # --   
    # 'andnot' is probably the closest analogue to 'andand'  (and Ruby's 
    # syntax - && !), unless you want to write out 'andandnot' :)
    alias_method :andnot, :aint
    
    alias_method :isnt, :aint
    alias_method :is_not, :aint
    # Removed #notnot in favor of #andnot
    
    # Just in case you can't keep your fingers off the Gs
    alias_method :aint_nothing?, :aint_nothin?
    alias_method :is_nothing?, :is_nothin?
    
    
    
    # Are you reading my notes? Well, cool!
    # I wrote this for my personal site -- jacob-stetser.com -- and thought
    # it might be useful to other people, so I extracted it!
    
    # Here's a few real-world uses:
    # [Create or find a user, assign to 'user' and check if new record all in one line]
    #    if (user = User.find_or_initialize_by_email(self.author_email)).is.new_record? ... end
    # 
    # [Safely simplify chained expressions] from:
    #    if @current_user and role = @current_user.role and role.admin?
    # to:
    #    if @current_user.ask.role.is.admin? 
    #
    # Wicked Sweet. Ciao!
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