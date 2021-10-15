//
//  AnswerViewController.swift
//  MagicAnswer
//
//  Created by Iryna Kopchynska on 27.09.2021.
//  Copyright © 2021 Iryna Kopchynska. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet var questionTextField: UITextField!
    @IBOutlet var answerLabel: CustomLabel!
    @IBOutlet var settingButton: UIBarButtonItem!
    
    var downloadAnswer = DownloadAnswer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel.text = "Shake!"
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: Notification.Name("didReceiveData"), object: nil)
    }
    
    private enum LocalConstant {
        static let minQuestionLength = 5
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if (questionTextField.text == "") ||
            (questionTextField.text == " ") ||
            (questionTextField.text?.count ?? 0 < LocalConstant.minQuestionLength){
            showError(with: ErrorType.emptyField)
        } else {
            if motion == .motionShake {
                downloadAnswer.getQuestionResponse()
            }
        }
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        DispatchQueue.main.async {
            self.answerLabel.text = notification.object as? String
        }
    }
    
    func showError(with type: ErrorType) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}
