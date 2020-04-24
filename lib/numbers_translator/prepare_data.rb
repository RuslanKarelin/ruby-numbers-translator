class NumbersTranslator::PrepareData

  def get_data
    prepare
  end

  protected

  def self.set(number)
    self.new(number)
  end

  private

  def initialize(number)
    @number = number
    @data = {}
  end

  def prepare
    string_number = @number.to_s.gsub(/(?<=\d)(?=(?:\d{3})+\z)/, ' ')
    @data.store(:numeric_groups, string_number.split)
    @data.store(:count_numeric_groups, @data[:numeric_groups].size)
    @data
  end
end