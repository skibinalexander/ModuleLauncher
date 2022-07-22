//
//  CommonSwinject.swift
//  Parcel
//
//  Created by Skibin Alexander on 15.12.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Swinject
import UIKit

public typealias ConfiguratorType = (NSObject & Assembly & ConfiguratorView)

/// Интерфейс для конфигуратора модуля взаимодействующего с View слоем
public protocol ConfiguratorView {
    
    /// Container assembly module
    var container: Container! { get set }
    
    /// View for presentation
    var view: UIViewController { get }
    
}

extension Container {
    
    /// Void configuration module
    public func configure<Configurator>(assembly: Configurator.Type) where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
    }
    
    /// Resolve configuration module
    /// - Returns: Configurator by ConfiguratorType
    public func configure<Configurator>(assembly: Configurator.Type) -> Configurator where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
        return configurator
    }
    
    /// Resolve configuration module
    /// - Returns: Configurator by UIViewController
    public func configure<Configurator>(assembly: Configurator.Type) -> UIViewController where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
        return configurator.view
    }
    
}

extension Container {
    
    public func resolveAsViewController<Service>(_ serviceType: Service.Type) -> UIViewController {
        guard let vc = self.resolve(serviceType) as? UIViewController else {
            fatalError("Can't cast \(serviceType) to UIViewController")
        }
        return vc
    }
    
}
