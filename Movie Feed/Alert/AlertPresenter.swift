//
//  AlertPresenter.swift
//  Movie Feed
// 
//  Created by DANCECOMMANDER on 24.09.2023.
//

import Foundation
import UIKit
import Alamofire

// MARK: - Alert Struct

struct AlertInfo {
    let title: String
    let message: String
}

// MARK: - Alert Presenter

final class AlertPresenter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func showAlert(alertInfo: AlertInfo) {
        guard let viewController = viewController else { return }
        let alertController = UIAlertController(
            title: alertInfo.title,
            message: alertInfo.message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showNetworkError(_ error: AFError) {
        let alertInfo = AlertInfo(title: "Ошибка сети", message: error.localizedDescription)
        showAlert(alertInfo: alertInfo)
    }
}
