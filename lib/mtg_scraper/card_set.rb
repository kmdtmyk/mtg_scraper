# frozen_string_literal: true

module MtgScraper
  module CardSet
    module_function

    def code_from_name(name)
      {
        '基本セット2020' => 'M20',
        '灯争大戦' => 'WAR',
        '基本セット2019' => 'M19',
      }[name]
    end

  end
end
