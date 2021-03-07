//
//  DependencyLauncherProtocol.swift
//  ModuleLauncher
//
//  Created by Скибин Александр on 07.03.2021.
//

import Swinject

/// Обьект хранящий в себе настройки наполнения
public protocol DependencyLauncherProtocol {
    
    /// Набор зависимостей
    var dependencies: [DependencyItemProtocol.Type] { get set }
    
}
