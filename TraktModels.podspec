Pod::Spec.new do |s|
  s.name             = "TraktModels"
  s.version          = "0.1.0"
  s.summary          = "Trakt.tv models in Swift for using during Movile courses."
  s.homepage         = "https://github.com/marcelofabri/TraktModels"
  s.license          = 'MIT'
  s.author           = { "Marcelo Fabri" => "me@marcelofabri.com" }
  s.source           = { :git => "https://github.com/marcelofabri/TraktModels.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marcelofabri_'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TraktModels' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'Foundation'
  s.dependency 'Argo', '~> 1.0'
  s.dependency 'ISO8601DateFormatter', '~> 0.7'
end
