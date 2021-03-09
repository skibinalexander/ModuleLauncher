Pod::Spec.new do |s|
  s.name             = 'ModuleLauncher'
  s.version          = '0.6.0'
  s.summary          = 'Abstraction of initialization modules with Swinject DI'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/skibinalexander/ModuleLauncher.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Skibin Alexander' => 'skibinalexander@gmail.com' }
  s.source           = { :git => 'https://github.com/skibinalexander/ModuleLauncher.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = "5.0"
  s.source_files = 'ModuleLauncher/Classes/**/*'
  s.dependency 'Swinject'
end
