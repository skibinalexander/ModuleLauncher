//
//  DependencyItemProtocol.swift
//  ModuleLauncher
//
//  Created by Скибин Александр on 07.03.2021.
//

import Swinject

/// Интерфейс описывающий зависимость
public protocol DependencyItemProtocol: class {
    
    /// Идентификатор зависимости
    var dependencyId: String { get }
    
    /// Контейнер для сборки зависимости
    var container: Container { get set }
    
    /// Контейнер - скоуп сборки
    var objectScope: ObjectScope { get set }
    
    /// Собрать зависимость
    func inject()
    
    // MARK: - Init
    
    init(container: Container, objectScope: ObjectScope)
    
    // MARK: - Static
    
    /// Создать модель зависимости
    /// - Parameters:
    ///   - container: Контейнер
    ///   - scope: Контейнер - скоуп
    static func create(
        in container: Container,
        with scope: ObjectScope
    ) -> DependencyItemProtocol
    
}

public extension DependencyItemProtocol {
    
    static func create(
        in container: Container,
        with scope: ObjectScope
    ) -> DependencyItemProtocol {
        return Self(container: container, objectScope: scope)
    }
    
}
