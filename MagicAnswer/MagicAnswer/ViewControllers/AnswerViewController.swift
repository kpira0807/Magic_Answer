import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet private weak var questionTextField: UITextField!
    @IBOutlet private weak var  answerLabel: CustomLabel!

    private let answerManager: AnswerManagerProtocol

    override func viewDidLoad() {
        super.viewDidLoad()

        answerLabel.text = L10n.answerLaber

        let settingButton = UIBarButtonItem.init(image: UIImage(systemName: "gear"),
                                                 style: .plain, target: self,
                                                 action: #selector(openSettingScreen))
        self.navigationItem.rightBarButtonItem  = settingButton
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    init?(coder: NSCoder, answerManager: AnswerManagerProtocol = AnswerManager()) {
        self.answerManager = answerManager
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private enum LocalConstant {
        static let minQuestionLength = 5
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if (questionTextField.text == "") ||
            (questionTextField.text == " ") ||
            (questionTextField.text?.count ?? 0 < LocalConstant.minQuestionLength) {
            showError(with: ErrorType.emptyField)
        } else {
            if motion == .motionShake {
                answerManager.getRandomAnswer { [weak self] answer in
                    self?.updateAnswerLabel(answer)
                }
            }
        }
    }

    private func updateAnswerLabel(_ answer: String) {
        DispatchQueue.main.async {
            self.answerLabel.text = answer
        }
    }

    @objc func openSettingScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewcontroller = storyboard.instantiateViewController(identifier: "SettingViewController",
                                                                  creator: {coder -> SettingViewController? in
                                                                    SettingViewController.init(coder: coder,
                                                                     answers: HardcodedAnswers(),
                                                                        storage: AnswerStorage())
        })
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }

    func showError(with type: ErrorType) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}
