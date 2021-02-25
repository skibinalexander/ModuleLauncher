//
//  DependencyModuleLauncherProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 15.12.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Swinject
import UIKit

/// Обьект хранящий в себе настройки наполнения
public protocol DependencyLauncherProtocol {}

/// Фабрика наполнения модуля
public protocol DependencyModuleFactoryProtocol {
    
    /// Установщик
    associatedtype Launcher: DependencyLauncherProtocol
    
    /// Сборка модуля и inject зависимостей в контейнере
    func launch<AssemblyModule: ConfiguratorType>(
        configurator: AssemblyModule.Type,
        coordinator: ConfiguratorCoordinator,
        with launcher: Launcher,
        in container: Container,
        preAssembly: ((Container) -> Void)?,
        postAssembly: ((Container) -> Void)?) -> (view: UIViewController, container: Container)
    
}
