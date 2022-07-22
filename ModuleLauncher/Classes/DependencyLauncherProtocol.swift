//
//  DependencyLauncherProtocol.swift
//  ModuleLauncher
//
//  Created by Скибин Александр on 07.03.2021.
//

import Swinject

/// Обьект хранящий в себе настройки наполнения
public protocol DependencyLauncherProtocol {
    
    /// List of dependenvies
    var dependencies: [DependencyItemProtocol.Type] { get set }
    
    /// Определение objectScope для зависимости
    /// - Parameter item: Зависимость
    func objectScope(for item: DependencyItemProtocol.Type) -> ObjectScope
    
}

public extension DependencyLauncherProtocol {
    func objectScope(for item: DependencyItemProtocol.Type) -> ObjectScope { .container }
}
