import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet private weak var chooseFirstHardcodeAnswer: UITextField!
    @IBOutlet private weak var presentFirstLabel: UILabel!
    @IBOutlet private weak var backgroundFirstView: CustomViewBackground!
    
    @IBOutlet private weak var chooseSecondHardcodeAnswer: UITextField!
    @IBOutlet private weak var presentSecondLabel: UILabel!
    @IBOutlet private weak var backgroundSecondView: CustomViewBackground!
    
    @IBOutlet private weak var chooseThirdHardcodeAnswer: UITextField!
    @IBOutlet private weak var presentThirdLabel: UILabel!
    @IBOutlet private weak var backgroundThirdView: CustomViewBackground!
    
    private let answers: HardcodedAnswers
    private let storage: AnswerStorageProtocol
    
    init?(coder: NSCoder, answers: HardcodedAnswers = HardcodedAnswers(), storage: AnswerStorageProtocol = AnswerStorage()) {
        self.answers = answers
        self.storage = storage
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let chooseFirstPickerView = UIPickerView()
    private let chooseSecondPickerView = UIPickerView()
    private let chooseThirdPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseFirstPickerView.delegate = self
        chooseFirstPickerView.dataSource = self
        
        chooseSecondPickerView.delegate = self
        chooseSecondPickerView.dataSource = self
        
        chooseThirdPickerView.delegate = self
        chooseThirdPickerView.dataSource = self
        
        chooseFirstHardcodeAnswer.inputView = chooseFirstPickerView
        let answerFirst = answers.firstArrayAnswers[0]
        chooseFirstHardcodeAnswer.text = answerFirst
        
        chooseSecondHardcodeAnswer.inputView = chooseSecondPickerView
        let answerSecond = answers.secondArrayAnswers[0]
        chooseSecondHardcodeAnswer.text = answerSecond
        
        chooseThirdHardcodeAnswer.inputView = chooseThirdPickerView
        let answerThird = answers.thirdArrayAnswers[0]
        chooseThirdHardcodeAnswer.text = answerThird
        
        saveUserAnswer([answerFirst, answerSecond, answerThird])
        
        presentFirstLabel.textColor = .whiteColor
        presentSecondLabel.textColor = .whiteColor
        presentThirdLabel.textColor = .whiteColor
    }
    
    private func saveUserAnswer(_ answers: [String]) {
        storage.saveAnswer(answers)
    }
}

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == chooseFirstPickerView {
            return answers.firstArrayAnswers.count
        } else if pickerView == chooseSecondPickerView {
            return answers.secondArrayAnswers.count
        } else if pickerView == chooseThirdPickerView {
            return answers.thirdArrayAnswers.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == chooseFirstPickerView {
            return answers.firstArrayAnswers[row]
        } else if pickerView == chooseSecondPickerView {
            return answers.secondArrayAnswers[row]
        } else if pickerView == chooseThirdPickerView {
            return answers.thirdArrayAnswers[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == chooseFirstPickerView {
            chooseFirstHardcodeAnswer.text = answers.firstArrayAnswers[row]
        } else if pickerView == chooseSecondPickerView {
            chooseSecondHardcodeAnswer.text = answers.secondArrayAnswers[row]
        } else if pickerView == chooseThirdPickerView {
            chooseThirdHardcodeAnswer.text = answers.thirdArrayAnswers[row]
        }
        let array = [chooseFirstHardcodeAnswer.text!, chooseSecondHardcodeAnswer.text!, chooseThirdHardcodeAnswer.text!]
        print(array)
        saveUserAnswer(array)
        self.view.endEditing(false)
    }
}
