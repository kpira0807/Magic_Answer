import UIKit

class AnswerViewModel {
    
    private let model: AnswerModel
    
    init(model: AnswerModel = AnswerModel()) {
        self.model = model
    }
    
    var updateAnswerLabel: ((String) -> Void)?
    var showError: ((ErrorType) -> Void)?
    
    func userDidShake(with question: String) {
        
        if isQuestionExist(question) {
            showError?(ErrorType.emptyField)
        } else {
            
            model.getRandomAnswer { answer in
                self.updateAnswerLabel?(answer)
            }
        }
    }
    private enum LocalConstant {
        static let minQuestionLength = 5
    }
    
    private func isQuestionExist(_ text: String?) -> Bool {
        return (text == "") ||
            (text == " ") ||
            (text?.count ?? 0 < LocalConstant.minQuestionLength)
    }
}

class AnswerViewController: UIViewController {
    
    @IBOutlet private weak var questionTextField: UITextField!
    @IBOutlet private weak var  answerLabel: CustomLabel!
    
    private let viewModel: AnswerViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel.text = "Shake!"
        
        let settingButton = UIBarButtonItem.init(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(openSettingScreen))
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
    
    init?(coder: NSCoder, viewModel: AnswerViewModel = AnswerViewModel()) {
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
        let vc = storyboard.instantiateViewController(identifier: "SettingViewController", creator: {coder -> SettingViewController? in SettingViewController.init(coder: coder, viewModel: SettingViewModel())
        })
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError(with type: ErrorType) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}
