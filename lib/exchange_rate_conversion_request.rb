class ExchangeRateConversionRequest
  attr_reader :result_message, :outcome

  def initialize(params)
    sanitized_params = {}
    params.each { |k, v| sanitized_params[k] = sanitize(k, v) }
    sanitized_params.each { |k, v| instance_variable_set("@#{k}", v) }
  end

  def run
    convert_date
    validate_params
    result = ExchangeRateJt.at(date, base, counter)
    @outcome = result[:status]
    @result_message = generate_result_message(result)
  rescue => exception
    @outcome = :failure
    @result_message = "Error: #{exception.message}"
  end

  private

  attr_reader :date, :base, :counter, :amount

  def sanitize(key, value)
    return value if key == 'date' # It does not like dates...
    Rack::Utils.escape_html(value) unless value.nil?
  end

  def convert_date
    @date = Date.parse(date) unless date.nil? || date == ''
  end

  def validate_params
    raise ArgumentError, 'Please fill in all fields' if missing_fields?
    raise ArgumentError, 'Amount must be a number greater than zero' if amount.to_i.zero?
  end

  def missing_fields?
    date.nil? || date == '' || base.nil? || base == '' ||
      counter.nil? || counter == '' || amount.nil? || amount == ''
  end

  def generate_result_message(result)
    case outcome
    when :success
      generate_success_message(result[:rate])
    when :failure
      generate_failure_message(result[:error])
    end
  end

  def generate_success_message(rate)
    "#{amount} #{base} = #{format_rate(rate)} #{counter}"
  end

  def generate_failure_message(error)
    "Error: #{error}"
  end

  def format_rate(rate)
    trim((rate * amount.to_f).truncate(2))
  end

  def trim(num)
    i = num.to_i
    f = num.to_f
    i == f ? i : f
  end
end
