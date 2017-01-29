class ApiConstraint

  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.godesk.v#{@version}")
  end

end

def api_version(version, default = nil)
  ApiConstraint.new(version: version, default: default.present?)
end
