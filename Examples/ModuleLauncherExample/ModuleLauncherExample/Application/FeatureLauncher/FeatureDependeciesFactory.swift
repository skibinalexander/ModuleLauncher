//
//  FeatureDependeciesFactory.swift
//  ModuleLauncherExample
//
//  Created by Скибин Александр on 07.03.2021.
//

import ModuleLauncher
import Swinject

struct FeatureDependeciesFactory: DependencyModuleFactoryProtocol {
    
    public func launch<AssemblyModule: ConfiguratorType>(
        configurator: AssemblyModule.Type,
        coordinator: ConfiguratorCoordinator,
        with launcher: DependencyLauncherProtocol,
        in container: Container,
        preAssembly: ((Container) -> Void)?,
        postAssembly: ((Container) -> Void)?
    ) -> (view: UIViewController, container: Container) {
        
        preAssembly?(container)
        
        let view: UIViewController =
            buildFeatures(
                in: container,
                with: launcher.dependencies
            )
            .configure(assembly: configurator)
        
        postAssembly?(container)
        
        return (view, container)
        
    }
    
    
    // MARK: - Private Implementation
    
    /// Расширенная сборка контейнера под фичу
    /// - Parameters:
    ///   - container: Контейнер зависимостей
    ///   - dependencies: Набор зависимостей
    /// - Returns: Контейнер с заполненными зависямости
    private func buildFeatures(
        in container: Container,
        with dependencies: [DependencyItemProtocol.Type]
    ) -> Container {
        
        dependencies.forEach {
            $0.create(
                in: container,
                with: .container
            )
            .inject()
        }
        
        return container
    }
    
}
