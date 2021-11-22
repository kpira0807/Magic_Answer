import UIKit

class AnswerViewController: UIViewController {

    private let answerLabel = UILabel()
    private let questionTextField = UITextField()

    private let viewModel: AnswerViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = L10n.navigationItemAVC

        let settingButton = UIBarButtonItem.init(image: UIImage(systemName: "gear"),
                                                 style: .plain, target: self,
                                                 action: #selector(openSettingScreen))
        self.navigationItem.rightBarButtonItem  = settingButton
        self.navigationController?.navigationBar.tintColor = UIColor.black

        customImage()
        customShakeLabel()
        customQuestionTextField()

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

    init?(_ viewModel: AnswerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        self.navigationController?.pushViewController(SettingViewController(SettingViewModel(model: SettingModel()))!,
            animated: true)
    }

    func showError(with type: ErrorType) {
        let myAlert = UIAlertController(title: L10n.errorAlert, message: type.message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: L10n.okeyAlert, style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}

extension AnswerViewController {

    private func customImage() {
        let imageView = UIImageView(image: Asset.ball.image)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func customShakeLabel() {
        answerLabel.text = L10n.answerLaber

        view.addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        answerLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        answerLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true

        answerLabel.textAlignment = NSTextAlignment.center
        answerLabel.textColor = Asset.newWhite.color
        answerLabel.font = UIFont.systemFont(ofSize: 15.0)
        answerLabel.numberOfLines = 0
        answerLabel.clipsToBounds = true
    }

    private func customQuestionTextField() {
        view.addSubview(questionTextField)
        let size = view.safeAreaLayoutGuide
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        questionTextField.topAnchor.constraint(equalTo: size.topAnchor, constant: 10).isActive = true
        questionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        questionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        questionTextField.placeholder = L10n.questionTextField

        questionTextField.borderStyle = UITextField.BorderStyle.roundedRect
        questionTextField.font = UIFont.init(name: "System", size: 14.0)
        questionTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        questionTextField.clipsToBounds = true
    }
}
