//
//  DependencyModuleLauncherProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 15.12.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Swinject
import UIKit

/// Фабрика наполнения модуля
public protocol DependencyModuleFactoryProtocol {
    
    /// Сборка модуля и inject зависимостей в контейнере
    func launch<AssemblyModule: ConfiguratorType>(
        configurator: AssemblyModule.Type,
        coordinator: ConfiguratorCoordinator,
        with launcher: DependencyLauncherProtocol?,
        in container: Container,
        preAssembly: ((Container) -> Void)?,
        postAssembly: ((Container) -> Void)?) -> (view: UIViewController, container: Container)
    
}

public protocol DependencyModuleFactoryInterceptor: class {
    
    /// Запуск фабрики interceptor пресборки
    /// - Parameters:
    ///   - factory: Фабрика зависимостей
    ///   - container: Контейнер зависимостей
    ///   - coordinator: Координатор для сборки модуля
    func launchPreAssembly(
        with factory: DependencyModuleFactoryProtocol,
        in container: Container,
        coordinator: ConfiguratorCoordinator
    )
    
    /// Запуск фабрики interceptor постсборки
    /// - Parameters:
    ///   - factory: Фабрика зависимостей
    ///   - container: Контейнер зависимостей
    ///   - coordinator: Координатор для сборки модуля
    func launchPostAssembly(
        with factory: DependencyModuleFactoryProtocol,
        in container: Container,
        coordinator: ConfiguratorCoordinator
    )
    
}

/// Базовая реализации фабрики
public struct DependencyModuleFactory: DependencyModuleFactoryProtocol {
    
    // MARK: - Static properties
    
    /// Статичный interceptor
    public static weak var interceptor: DependencyModuleFactoryInterceptor?
    
    // MARK: - Public properties
    
    public weak var interceptor: DependencyModuleFactoryInterceptor?
    
    // MARK: - Initialization
    
    public init(interceptor: DependencyModuleFactoryInterceptor? = nil) {
        self.interceptor = interceptor
    }
    
    // MARK: - DependencyModuleFactoryProtocol
    
    public func launch<AssemblyModule: ConfiguratorType>(
        configurator: AssemblyModule.Type,
        coordinator: ConfiguratorCoordinator,
        with launcher: DependencyLauncherProtocol?,
        in container: Container,
        preAssembly: ((Container) -> Void)?,
        postAssembly: ((Container) -> Void)?
    ) -> (view: UIViewController, container: Container) {
        
        /// Запуск работы статичного interceptor
        Self.interceptor?
            .launchPreAssembly(
                with: self,
                in: container,
                coordinator: coordinator
            )
        
        /// Запуск работы  interceptor
        self.interceptor?
            .launchPreAssembly(
                with: self,
                in: container,
                coordinator: coordinator
            )
        
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
        Self.interceptor?
            .launchPostAssembly(
                with: self,
                in: container,
                coordinator: coordinator
            )
        
        /// Запуск работы  interceptor
        self.interceptor?
            .launchPostAssembly(
                with: self,
                in: container,
                coordinator: coordinator
            )
        
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
            $0.create(
                in: container,
                with: launcher?.objectScope(for: $0) ?? .container
            )
            .inject()
        }
        
        return container
    }
    
}
