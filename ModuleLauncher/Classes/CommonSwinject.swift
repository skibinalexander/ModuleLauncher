//
//  CommonSwinject.swift
//  Parcel
//
//  Created by Skibin Alexander on 15.12.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Swinject

public protocol ConfiguratorView {
    
    /// Container assembly module
    var container: Container! { get set }
    
    /// Coordinator for presentation
    var coordinator: ConfiguratorCoordinator! { get }
    
    /// ViewController of Module
    func getView() -> UIViewController
    
}

extension ConfiguratorView {
    
    public var coordinator: ConfiguratorCoordinator! {
        container.resolve(ConfiguratorCoordinator.self)
    }
    
}

public typealias ConfiguratorType = (NSObject & Assembly & ConfiguratorView)

extension Container {
    
    func configure<Configurator>(assembly: Configurator.Type) where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
    }
    
    func configure<Configurator>(assembly: Configurator.Type) -> Configurator where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
        return configurator
    }
    
    func configure<Configurator>(assembly: Configurator.Type) -> UIViewController where Configurator: ConfiguratorType {
        let configurator = Configurator()
        configurator.assemble(container: self)
        return configurator.getView()
    }
    
}

extension Container {
    
    func resolveAsViewController<Service>(_ serviceType: Service.Type) -> UIViewController {
        guard let vc = self.resolve(serviceType) as? UIViewController else {
            fatalError("Can't cast \(serviceType) to UIViewController")
        }
        return vc
    }
    
}

// MARK: - Route Modules

public protocol CoordinatorCustomPresentation: class {
    
    var container: Container! { get set }
    
    /// Кастомное показать
    func show()
    
    /// Кастомно скрыть
    func dissmis()

}

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
