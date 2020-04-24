class NumbersTranslator::Engine

  FIRST_POSITION = 1

  SECOND_POSITION = 2

  FIRST_NUMBER = 0

  SECOND_NUMBER = 1

  THIRD_NUMBER = 2

  def initialize(data, data_storage, lang)
    @data = data.get_data
    @data_storage = data_storage
    @separator = (lang == 'uk') ? ' and ' : ' '
    @lang = lang
    @result_string = ''
  end

  def run

    @data[:numeric_groups].each do |key|
      data = ''

      if key.length > 1

        data = for_fist_element(key, data) if key.length == 3

        if key[THIRD_NUMBER]
          if_count_numbers_three(key, data)
        else
          if_count_numbers_not_three(key, data)
        end
      else
        for_fist_element(key, data);
      end

      if key.split('').map {|e| e.to_i}.sum != 0
        @result_string += ' ' + @data_storage[:breakdown][@data[:count_numeric_groups].to_s]
      end

      @data[:count_numeric_groups] -= 1

    end
    postprocessing
  end

  protected

  def get_from_storage_and_concat(params)

    if params[:for_search_in_the_storage].is_a? Array

      data = @data_storage[:comparison][
          params[:key][params[:for_search_in_the_storage][FIRST_NUMBER]] +
              params[:key][params[:for_search_in_the_storage][SECOND_NUMBER]]
      ]

      params[:data] = data
      concatenation_to_string(params)
    else
      data = @data_storage[:comparison][params[:key][params[:key_in_storage]]]

      params[:data] = data
      data = concatenation_to_string(params)
    end

    data
  end

  def concatenation_to_string(params)
    str = ''

    if params[:data].is_a? Hash

      if params[:position]
        str = (params[:position] == FIRST_POSITION) ?
                  "-#{params[:data][params[:position].to_s]}" :
                  "#{@separator}#{params[:data][params[:position].to_s]}"

        str.gsub!('-', @separator) if params[:before_zero]
      else
        str = " #{params[:data][params[:key].length.to_s]}"
      end

    else
      str = params[:not_and] ? params[:data] : @separator + params[:data] unless params[:data].empty?
    end
    @result_string += str
    ''
  end

  def if_count_numbers_three(key, data)

    if @data_storage[:comparison].has_key?(key[SECOND_NUMBER] +
                                               key[THIRD_NUMBER]
    )
      data = get_from_storage_and_concat(
          key: key,
          data: data,
          for_search_in_the_storage: [SECOND_NUMBER, THIRD_NUMBER]
      )
    end

    if data.empty?

      get_from_storage_and_concat(
          key_in_storage: SECOND_NUMBER,
          key: key,
          data: data,
          position: SECOND_POSITION
      )

      data = @data_storage[:comparison][key[THIRD_NUMBER]]

      data = key[SECOND_NUMBER] != '0' ?

                 concatenation_to_string(
                     key: key,
                     data: data,
                     position: FIRST_POSITION
                 ) :

                 concatenation_to_string(
                     key: key,
                     data: data,
                     position: FIRST_POSITION,
                     before_zero: true
                 )
    end

    data
  end

  def if_count_numbers_not_three(key, data)

    if @data_storage[:comparison].has_key?(
        key[FIRST_NUMBER] +
            key[SECOND_NUMBER]
    )
      data = get_from_storage_and_concat(
          key: key,
          data: data,
          position: nil,
          not_and: true,
          for_search_in_the_storage: [FIRST_NUMBER, SECOND_NUMBER]
      )
    else
      if key.length == 2

        data = get_from_storage_and_concat(
            key_in_storage: FIRST_NUMBER,
            key: key,
            data: data,
            position: SECOND_POSITION,
            not_and: true
        )

        data = get_from_storage_and_concat(
            key_in_storage: SECOND_NUMBER,
            key: key,
            data: data,
            position: FIRST_POSITION
        )
      else

        data = get_from_storage_and_concat(
            key_in_storage: SECOND_NUMBER,
            key: key,
            data: data
        )
      end
    end

    data
  end

  def for_fist_element(key, data)
    get_from_storage_and_concat(
        key_in_storage: FIRST_NUMBER,
        key: key,
        data: data
    )
  end

  def postprocessing

    if @result_string.start_with?(@separator) && @lang == 'uk'
      @result_string = @result_string.slice(@separator.length..@result_string.length)
    end

    @result_string.strip
  end

  def get_params
    {
        key_in_storage: nil,
        key: nil,
        data: '',
        position: nil,
        not_and: nil,
        before_zero: nil,
        for_search_in_the_storage: nil
    }
  end

  def merge_params(params)
    get_params.merge(params)
  end
end