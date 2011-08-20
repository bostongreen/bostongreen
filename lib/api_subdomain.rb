class ApiSubdomain
  def self.matches?(request)
    if Rails.env.development?
      true
    elsif Rails.env.staging?
      request.subdomain.present? && request.subdomain == "api.beta"
    elsif Rails.env.production?
      request.subdomain.present? && request.subdomain == "api"
    end
  end
end