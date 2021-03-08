//
//  ExampleServiceDependency.swift
//  ModuleLauncherExample
//
//  Created by Скибин Александр on 07.03.2021.
//

import ModuleLauncher
import Swinject

class ExampleServiceDependencyItem: DependencyItemProtocol {
    
    var dependencyId: String {
        "ExampleServiceDependencyItem"
    }
    
    var container: Container
    var objectScope: ObjectScope
    
    // MARK: - Initialization
    
    required init(container: Container, objectScope: ObjectScope) {
        self.container = container
        self.objectScope = objectScope
    }
    
    /// Собрать зависимость
    func inject() {
        container.register(ExampleServiceProtocol.self) { _ in
            ExampleService()
        }
    }
    
}
