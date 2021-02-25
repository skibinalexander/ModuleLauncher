//
//  ModuleLauncher+Coordinator.swift
//  Parcel
//
//  Created by Скибин Александр on 25.02.2021.
//  Copyright © 2021 Skibin Development. All rights reserved.
//

import Swinject
import UIKit

/// Интерфейс для реализации координации модулей
public protocol ConfiguratorCoordinator {
    
    /// Презентация View для Root UIWindow
    func display(view: UIViewController)
    
    // MARK: - Navigation Stack
    
    /// Презентация View для Navigation Stack
    /// - Parameters:
    ///   - navigation: Navigation Controller
    ///   - presentView: Презентуемый контроллер
    ///   - navigationView: Контроллер стека
    ///   - container: Контейнер нового модуля
    func push(
        presentView: UIViewController,
        on navigationView: UINavigationController?,
        in container: Container)
    
    /// Переход к Root контроллера в стеке
    func popToRoot(view: UIViewController)
    
    /// Скрыть контроллер из стека
    func pop(view: UIViewController)
    
    /// Удаление контроллера из стека навигации
    /// - Parameters:
    ///   - index: Индекс по которому выполнить удаление
    ///   - view: Стек навигации
    func removeViewFromStack(
        at index: Int,
        from navigationView: UINavigationController?)
    
    /// Удаление из стека по range
    /// - Parameters:
    ///   - range: Range  в котором выполнить удаление
    ///   - view: Стек навигации
    func removeViewFromStack(
        with range: Range<Int>,
        from navigationView: UINavigationController?)
    
    // MARK: - Modal Stack
    
    /// Отобразить View модально
    /// - Parameter view: Презентуемый контроллер
    func present(
        view: UIViewController,
        on controller: UIViewController,
        in container: Container)
    
    /// Скрыть модально показанный контроллер
    func dissmis(view: UIViewController)
    
    // MARK: - Custom
    
    /// Кастомный способ презентации контроллера
    /// - Parameter presentation: Модель презентации
    func present(custom: CoordinatorCustomPresentation)
    
    /// Кастомный способ скрытия контроллера
    /// - Parameter custom: Модель скрытия
    func dissmis(custom: CoordinatorCustomPresentation)
    
}

// MARK: - Route Modules

/// Абстракция реализации кастомной координации модулей
public protocol CoordinatorCustomPresentation: class {
    
    var container: Container! { get set }
    
    /// Кастомное показать
    func show()
    
    /// Кастомно скрыть
    func dissmis()

}
