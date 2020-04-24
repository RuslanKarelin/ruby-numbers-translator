class NumbersTranslator::Validator

  def self.validate(number)
    number = number.to_s
    return (@@pattern.match(number) && number.length <= 16) || false
  end

  protected

  @@pattern = /^[0-9]+$/
end