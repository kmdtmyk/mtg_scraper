# frozen_string_literal: true

module CardSet
  module_function

  def code_from_name(name)
    {
      '灯争大戦' => 'WAR',
    }[name]
  end

end
