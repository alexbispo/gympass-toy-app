class FlashMessages
  TYPES = %i[alert notice].freeze
  CSS_CLASS_TYPES = { alert: "danger", notice: "success" }.freeze

  def self.call(flash)
    TYPES.each_with_object({}) do |type, buffer|
      message = flash[type]
      buffer[type] = message if message
    end
  end

  def self.css_class(type)
    CSS_CLASS_TYPES[type]
  end
end
