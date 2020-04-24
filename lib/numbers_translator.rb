require "numbers_translator/version"
require "numbers_translator/validator"
require "numbers_translator/prepare_data"
require "numbers_translator/data_storage"
require "numbers_translator/engine"

module NumbersTranslator
  class Translator
    def self.make(number, lang = 'uk')

      unless Validator.validate number
        raise ArgumentError, 'Invalid characters are present or a number greater than 16 characters!'
      end

      engine = Engine.new(
          PrepareData.set(number),
          DataStorage.get_storage,
          lang
      )
      engine.run
    end
  end

  private

  def initialize
  end
end