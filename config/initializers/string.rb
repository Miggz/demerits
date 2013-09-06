unless String.instance_methods.include? :to_bool
  class String
    def to_bool
      return true if self =~ (/\A(true|t|yes|y|1)\Z/i)
      return false if self.blank? || self =~ (/\A(false|f|no|n|0)\Z/i)
      raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
    end
  end
end
