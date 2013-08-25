module OmniAuthHelper
  class Dsl
    def initialize(model, hash)
      @model = model
      @hash = hash
    end

    def defaults(*methods)
      methods.each { |m| invoke_model "#{m}=", @hash[m.to_s] }
    end

    def overrides(hash)
      hash.each do |key, value|
        val = value.is_a?(Proc) ? value.call(@hash) : @hash[value.to_s]
        invoke_model "#{key}=", val
      end
    end

    def invoke_model(method, value)
      @model.send(method, value) if @model.respond_to? method and !value.nil?
    end

    def traverse(name, &block)
      hash = @hash[name.to_s]
      if [Hash, Array].reduce(false) {|valid, klass| valid or hash.class <= klass }
        hash = (hash.is_a? Hash) ? hash : hash[0]
        Dsl.new(@model, hash).instance_eval(&block) if hash
      end
    end

    def self.assign(model, hash, &block)
      new(model, hash).instance_eval(&block)
    end
  end

  def populate_from_auth(auth, &block)
    Dsl.assign(self, auth, &block)
  end
end
