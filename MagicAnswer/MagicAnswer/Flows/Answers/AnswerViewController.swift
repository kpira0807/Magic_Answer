import UIKit
import RxSwift
import RxCocoa

class AnswerViewController: UIViewController {
    
    private let answerLabel = UILabel()
    private let questionTextField = UITextField()
    private let viewBackground = UIView()
    private let imageView = UIImageView(image: Asset.ball.image)
    
    private let viewModel: AnswerViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.title = L10n.navigationItemAVC
        
        let settingButton = UIBarButtonItem.init(image: UIImage(systemName: "gear"),
                                                 style: .plain, target: self,
                                                 action: #selector(openSettingScreen))
        self.navigationItem.rightBarButtonItem  = settingButton
        self.navigationController?.navigationBar.tintColor = Asset.newBlack.color
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.newBlack.color]
        
        customView()
        customImage()
        customShakeLabel()
        customQuestionTextField()
        subscribeOnChanges()
    }
    private let disposeBag = DisposeBag()
    
    private func subscribeOnChanges() {
        viewModel.answerText.subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let text):
                self?.updateAnswerLabel(text)
            case .failed(let error):
                self?.showError(with: error)
            }
        })
            .disposed(by: disposeBag)
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
        viewBackground.shake(3.0)
        viewModel.userDidShake(with: questionTextField.text ?? "")
    }
    
    private func updateAnswerLabel(_ answer: String) {
        animateAnswerLabel(answer: answer, label: answerLabel)
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
    
    private func customView() {
        view.addSubview(viewBackground)
        viewBackground.translatesAutoresizingMaskIntoConstraints = false
        viewBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewBackground.widthAnchor.constraint(equalToConstant: 350).isActive = true
        viewBackground.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    private func customImage() {
        viewBackground.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: viewBackground.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: viewBackground.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: viewBackground.topAnchor).isActive = true
    }
    
    private func customShakeLabel() {
        answerLabel.text = L10n.answerLaber
        viewBackground.addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor).isActive = true
        answerLabel.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor).isActive = true
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
    
    private func animationView() {
        let viewShakeAnimation = CABasicAnimation(keyPath: "position")
        viewShakeAnimation.duration = 0.2
        viewShakeAnimation.repeatCount = .infinity
        viewShakeAnimation.autoreverses = true
        viewShakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        viewShakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        viewBackground.layer.add(viewShakeAnimation, forKey: "position")
    }
    
    private func animateAnswerLabel(answer: String, label: UILabel) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                label.transform = .init(scaleX: 1.5, y: 1.5)
            }) { (finished: Bool) -> Void in
                label.text = answer
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    label.transform = .identity
                })
            }
        }
    }
}
