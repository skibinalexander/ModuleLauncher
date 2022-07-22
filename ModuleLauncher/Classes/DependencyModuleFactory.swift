//
//  DependencyModuleLauncherProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 15.12.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Swinject
import UIKit

///
public typealias LaunchModule = (view: UIViewController, container: Container)

/// Фабрика наполнения модуля
public protocol DependencyModuleFactoryProtocol {
    
    /// Сборка модуля и inject зависимостей в контейнере
    func launch<AssemblyModule: ConfiguratorType>(
        configurator: AssemblyModule.Type,
        with launcher: DependencyLauncherProtocol?,
        in container: Container,
        preAssembly: ((Container) -> Void)?,
        postAssembly: ((Container) -> Void)?) -> LaunchModule
    
}

public protocol DependencyModuleFactoryInterceptor: AnyObject {
    
    /// Запуск фабрики interceptor пресборки
    /// - Parameters:
    ///   - factory: Фабрика зависимостей
    ///   - container: Контейнер зависимостей
    ///   - coordinator: Координатор для сборки модуля
    func launchPreAssembly(
        with factory: DependencyModuleFactoryProtocol,
        in container: Container
    )
    
    /// Запуск фабрики interceptor постсборки
    /// - Parameters:
    ///   - factory: Фабрика зависимостей
    ///   - container: Контейнер зависимостей
    ///   - coordinator: Координатор для сборки модуля
    func launchPostAssembly(
        with factory: DependencyModuleFactoryProtocol,
        in container: Container
    )
    
}

/// Базовая реализации фабрики
public struct DependencyModuleFactory: DependencyModuleFactoryProtocol {
    
    // MARK: - Static properties
    
    /// Статичный interceptor
    public static weak var staticInterceptor: DependencyModuleFactoryInterceptor?
    
    // MARK: - Public properties
    
    public weak var localInterceptor: DependencyModuleFactoryInterceptor?
    
    // MARK: - Initialization
    
    public init(localInterceptor: DependencyModuleFactoryInterceptor? = nil) {
        self.localInterceptor = localInterceptor
    }
    
    // MARK: - DependencyModuleFactoryProtocol
    
    public func launch<AssemblyModule: ConfiguratorType>(
        configurator: AssemblyModule.Type,
        with launcher: DependencyLauncherProtocol? = nil,
        in container: Container,
        preAssembly: ((Container) -> Void)?,
        postAssembly: ((Container) -> Void)?
    ) -> LaunchModule {
        
        /// Запуск работы статичного interceptor
        Self.staticInterceptor?.launchPreAssembly(with: self, in: container)
        
        /// Запуск работы  interceptor
        self.localInterceptor?.launchPreAssembly(with: self, in: container)
        
        /// Callback пресборки в контейнер
        preAssembly?(container)
        
        /// Сборка модуля
        let view: UIViewController =
            buildFeatures(
                launcher: launcher,
                in: container,
                with: launcher?.dependencies ?? []
            )
            .configure(assembly: configurator)
        
        /// Callback постсборки в контейнер
        postAssembly?(container)
        
        /// Запуск работы статичного interceptor
        Self.staticInterceptor?.launchPostAssembly(with: self, in: container)
        
        /// Запуск работы  interceptor
        self.localInterceptor?.launchPostAssembly(with: self, in: container)
        
        return (view, container)
        
    }
    
    
    // MARK: - Private Implementation
    
    /// Расширенная сборка контейнера под фичу
    /// - Parameters:
    ///   - container: Контейнер зависимостей
    ///   - dependencies: Набор зависимостей
    /// - Returns: Контейнер с заполненными зависямости
    private func buildFeatures(
        launcher: DependencyLauncherProtocol?,
        in container: Container,
        with dependencies: [DependencyItemProtocol.Type]
    ) -> Container {
        dependencies.forEach {
            $0.init(container: container, objectScope: launcher?.objectScope(for: $0) ?? .container).inject()
        }
        
        return container
    }
    
}
