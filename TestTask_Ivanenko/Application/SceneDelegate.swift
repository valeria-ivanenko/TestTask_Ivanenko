//
//  SceneDelegate.swift
//  TestTask_Ivanenko
//
//  Created by Valeriia Ivanenko on 24.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - Lifecycle
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

