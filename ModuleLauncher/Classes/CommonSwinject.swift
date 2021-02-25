//
//  CommonSwinject.swift
//  Parcel
//
//  Created by Skibin Alexander on 15.12.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Swinject

public typealias ConfiguratorType = (NSObject & Assembly & ConfiguratorView)

/// Интерфейс для конфигуратора модуля взаимодействующего с View слоем
public protocol ConfiguratorView {
    
    /// Container assembly module
    var container: Container! { get set }
    
    /// Coordinator for presentation
    var coordinator: ConfiguratorCoordinator! { get }
    
    /// ViewController of Module
    func getView() -> UIViewController
    
}

extension ConfiguratorView {
    
    public var coordinator: ConfiguratorCoordinator! {
        container.resolve(ConfiguratorCoordinator.self)
    }
    
}

extension Container {
    
    func configure<Configurator>(assembly: Configurator.Type) where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
    }
    
    func configure<Configurator>(assembly: Configurator.Type) -> Configurator where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
        return configurator
    }
    
    func configure<Configurator>(assembly: Configurator.Type) -> UIViewController where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
        return configurator.getView()
    }
    
}

extension Container {
    
    func resolveAsViewController<Service>(_ serviceType: Service.Type) -> UIViewController {
        guard let vc = self.resolve(serviceType) as? UIViewController else {
            fatalError("Can't cast \(serviceType) to UIViewController")
        }
        return vc
    }
    
}
