import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet private weak var questionTextField: UITextField!
    @IBOutlet private weak var  answerLabel: CustomLabel!

    private let viewModel: AnswerViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        answerLabel.text = L10n.answerLaber

        let settingButton = UIBarButtonItem.init(image: UIImage(systemName: "gear"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(openSettingScreen))
        self.navigationItem.rightBarButtonItem  = settingButton
        self.navigationController?.navigationBar.tintColor = UIColor.black

        setup()
    }

    private func setup() {

        viewModel.updateAnswerLabel = { [weak self] answer in
            self?.updateAnswerLabel(answer)
        }

        viewModel.showError = { [weak self] error in
            self?.showError(with: error)
        }
    }

    init?(coder: NSCoder, viewModel: AnswerViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

        guard motion == .motionShake else {
            return
        }
        viewModel.userDidShake(with: questionTextField.text ?? "")

    }

    private func updateAnswerLabel(_ answer: String) {
        DispatchQueue.main.async {
            self.answerLabel.text = answer
        }
    }

    @objc func openSettingScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "SettingViewController",
                                                      creator: {coder -> SettingViewController? in SettingViewController.init(coder: coder,
                                                                       viewModel: SettingViewModel(model: SettingModel()))
        })
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // with type: ErrorType
    func showError(with type: ErrorType) {
        let myAlert = UIAlertController(title: L10n.errorAlert, message: type.message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: L10n.okeyAlert, style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}
