# frozen_string_literal: true

module CardName
  module_function

  def basic_land?(name)
    [
      '平地',
      '島',
      '沼',
      '山',
      '森',
      '荒地',
      'Plains',
      'Island',
      'Swamp',
      'Mountain',
      'Forest',
      'Wastes',
    ].include?(name)
  end

end
