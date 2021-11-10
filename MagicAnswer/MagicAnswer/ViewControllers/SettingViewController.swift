import UIKit

class SettingViewController: UIViewController {

    @IBOutlet private weak var firstHardcodeAnswerTextField: UITextField!
    @IBOutlet private weak var presentFirstLabel: UILabel!
    @IBOutlet private weak var backgroundFirstView: CustomViewBackground!

    @IBOutlet private weak var secondHardcodeAnswerTextField: UITextField!
    @IBOutlet private weak var presentSecondLabel: UILabel!
    @IBOutlet private weak var backgroundSecondView: CustomViewBackground!

    @IBOutlet private weak var thirdHardcodeAnswerTextField: UITextField!
    @IBOutlet private weak var presentThirdLabel: UILabel!
    @IBOutlet private weak var backgroundThirdView: CustomViewBackground!

    private let answers: HardcodedAnswers
    private let storage: AnswerStorageProtocol

    private let firstPickerView = UIPickerView()
    private let secondPickerView = UIPickerView()
    private let thirdPickerView = UIPickerView()

    init?(coder: NSCoder, answers: HardcodedAnswers = HardcodedAnswers(),
          storage: AnswerStorageProtocol = AnswerStorage()) {
        self.answers = answers
        self.storage = storage
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        firstPickerView.delegate = self
        firstPickerView.dataSource = self

        secondPickerView.delegate = self
        secondPickerView.dataSource = self

        thirdPickerView.delegate = self
        thirdPickerView.dataSource = self

        firstHardcodeAnswerTextField.inputView = firstPickerView
        let answerFirst = answers.firstArrayAnswers[0]
        firstHardcodeAnswerTextField.text = answerFirst

        secondHardcodeAnswerTextField.inputView = secondPickerView
        let answerSecond = answers.secondArrayAnswers[0]
        secondHardcodeAnswerTextField.text = answerSecond

        thirdHardcodeAnswerTextField.inputView = thirdPickerView
        let answerThird = answers.thirdArrayAnswers[0]
        thirdHardcodeAnswerTextField.text = answerThird

        saveUserAnswer([answerFirst, answerSecond, answerThird])

        presentFirstLabel.textColor = UIColor(asset: Asset.newWhite)
        presentSecondLabel.textColor = UIColor(asset: Asset.newWhite)
        presentThirdLabel.textColor = UIColor(asset: Asset.newWhite)
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
        if pickerView == firstPickerView {
            return answers.firstArrayAnswers.count
        } else if pickerView == secondPickerView {
            return answers.secondArrayAnswers.count
        } else if pickerView == thirdPickerView {
            return answers.thirdArrayAnswers.count
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstPickerView {
            return answers.firstArrayAnswers[row]
        } else if pickerView == secondPickerView {
            return answers.secondArrayAnswers[row]
        } else if pickerView == thirdPickerView {
            return answers.thirdArrayAnswers[row]
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == firstPickerView {
            firstHardcodeAnswerTextField.text = answers.firstArrayAnswers[row]
        } else if pickerView == secondPickerView {
            secondHardcodeAnswerTextField.text = answers.secondArrayAnswers[row]
        } else if pickerView == thirdPickerView {
            thirdHardcodeAnswerTextField.text = answers.thirdArrayAnswers[row]
        }
        let array = [firstHardcodeAnswerTextField.text!,
                     secondHardcodeAnswerTextField.text!,
                     thirdHardcodeAnswerTextField.text!]
        print(array)
        saveUserAnswer(array)
        self.view.endEditing(false)
    }
}
