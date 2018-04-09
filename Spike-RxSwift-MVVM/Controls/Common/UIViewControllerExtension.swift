//
//  UIViewControllerExtension.swift
//  Spike-RxSwift-MVVM
//
//  Created by 石井幸次 on 2018/04/09.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Foundation
import UIKit

protocol Alertable {
}

extension UIViewController: Alertable {
    /// PositiveボタンのみのAlertDialogを表示する
    ///
    /// - Parameters:
    ///   - message: メッセージ
    ///   - positiveListener: OKボタンの動作
    func alertDialog(message: String, positiveListener: ((UIAlertAction) -> Void)? = nil) {
        return self.alertDialog(message: message, positiveListener: positiveListener, negativeLabel: nil)
    }

    private func alertDialog(message: String,
                             positiveLabel: String? = "OK",
                             positiveListener: ((UIAlertAction) -> Void)? = nil,
                             negativeLabel: String? = "キャンセル",
                             negativeListener: ((UIAlertAction) -> Void)? = nil,
                             title: String? = nil) {
        if self is UIAlertController {
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: positiveLabel, style: .default, handler: { action in
            if let handler = positiveListener {
                handler(action)
            }
        }))

        if let negativeLabel = negativeLabel {
            alertController.addAction(UIAlertAction(title: negativeLabel, style: .cancel, handler: { action in
                if let handler = negativeListener {
                    handler(action)
                }
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
