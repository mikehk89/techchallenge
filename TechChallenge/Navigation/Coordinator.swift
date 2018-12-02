//
//  Coordinator.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit
/* Contains navigation logic for the app */
public class Coordinator {

  public var window: UIWindow

  private weak var currentViewController: UIViewController?

  fileprivate let transitionQueue = DispatchQueue(label: "com.techchallenge.coordinator.transition")
  fileprivate let transitionSemaphore = DispatchSemaphore(value: 1)

  init() {
    self.window = UIWindow(frame: UIScreen.main.bounds)
  }

  func transitTo(screen: Screen, transition: ScreenTransition, completion: (() -> Void)? = nil) {
    guard self.window.rootViewController != nil else {
      self.transit(screen: screen, transition: .root) {
        completion?()
      }
      return
    }
    transitionQueue.async {
      self.transitionSemaphore.wait()
      DispatchQueue.main.async {
        self.transit(screen: screen, transition: transition, completion: {
          self.transitionSemaphore.signal()
          completion?()
        })
      }
    }
  }

  private func transit(screen: Screen, transition: ScreenTransition, completion: (() -> Void)?) {

    switch transition {
    case .root:
      rootTransit(to: screen, completion: completion)
    case .modal:
      modalTransition(screen: screen, animated: true, completion: completion)
    }
  }

  private func rootTransit(to screen: Screen, completion: (() -> Void)?) {
    let viewController = screen.viewController()
    if let currentRootViewController = window.rootViewController {
      currentRootViewController.dismissAllPresented(animated: true, completion: {
        self.currentViewController = Coordinator.activeViewController(for: viewController)
        viewController.view.frame = currentRootViewController.view.frame
        viewController.view.layoutIfNeeded()
        UIView.transition(with: self.window,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.window.rootViewController = viewController
        }, completion: { _ in
          completion?()
        })
      })
    } else {
      currentViewController = Coordinator.activeViewController(for: viewController)
      window.rootViewController = viewController
      completion?()
    }
  }

  private func modalTransition(screen: Screen,
                                  animated: Bool,
                                  completion: (() -> Void)?) {
    let viewController = screen.viewController()

    if let cur = currentViewController {
      cur.present(viewController, animated: animated, completion: {
        self.currentViewController = Coordinator.activeViewController(for: viewController)
        completion?()
      })
    } else {
      completion?()
    }
  }

  public func dismiss(animated: Bool,
                      completion: (() -> Void)?) {
    transitionQueue.async {
      self.transitionSemaphore.wait()
      DispatchQueue.main.async {
        self._dismiss(animated: animated, completion: {
          self.transitionSemaphore.signal()
          completion?()
        })
      }
    }
  }

  private func _dismiss(animated: Bool,
                        completion: (() -> Void)?) {
  /*Note: this implementation is not complete. It will handle dismissing modally only. You will need to extend it for example to handle if the view controller was presented via a push transition. */

    let nextCurrentViewcontroller = currentViewController?.presentingViewController ?? window.rootViewController
    currentViewController?.dismiss(animated: animated, completion: {
      self.currentViewController = nextCurrentViewcontroller
      completion?()
    })
  }

  public static func activeViewController(for viewController: UIViewController) -> UIViewController {
    if let nav = viewController as? UINavigationController {
      return nav.topViewController!
    } else {
      return viewController
    }
  }
}

private extension UIViewController {
  func dismissAllPresented(animated: Bool, completion: (() -> Void)? = nil) {
    if let presented = self.presentedViewController {
      presented.dismissAllPresented(animated: animated) {
        self.dismiss(animated: animated, completion: completion)
      }
    } else {
      completion?()
    }
  }
}
