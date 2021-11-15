import UIKit

class SettingViewModel {
    
    private let model: SettingModel
    private var currentFields: Fields
    
    typealias Fields = (first: String?, second: String?, third: String?)
    var updateData: ((Fields) -> ())?
    
    init(model: SettingModel = SettingModel()){
        self.model = model
        self.currentFields = SettingViewModel.convertToFields(model.getAndUpdateDefaultQuestion())
    }
    
    func viewLoaded() {
        updateData?(currentFields)
    }
    
    private static func convertToFields(_ convertAnswer: [String]) -> Fields {
        let convertAnswer1 = convertAnswer[0]
        let convertAnswer2 = convertAnswer[1]
        let convertAnswer3 = convertAnswer[2]
        
        let fields: Fields = (first: convertAnswer1, second: convertAnswer2, third: convertAnswer3)
        return fields
    }
    
    func firstAnswerDidSelectRow(row: Int) {
        let answer = model.getAndUpdateFirstAnswer(for: row)
        currentFields.first = answer
        updateData?(currentFields)
    }
    
    func secondAnswerDidSelectRow(row: Int) {
        let answer = model.getAndUpdateSecondAnswer(for: row)
        currentFields.second = answer
        updateData?(currentFields)
    }
    
    func thirdAnswerDidSelectRow(row: Int) {
        let answer = model.getAndUpdateThirdAnswer(for: row)
        currentFields.third = answer
        updateData?(currentFields)
    }
    
    func getFirstAnswerNum() -> Int {
        return model.firstAnswer.count
    }
    
    func getSecondAnswerNum() -> Int {
        return model.secondAnswer.count
    }
    
    func getThirdAnswerNum() -> Int {
        return model.thirdAnswer.count
    }
    
    func getFirstAnswers(for row: Int) -> String? {
        return model.firstAnswer[row]
    }
    
    func getSecondAnswers(for row: Int) -> String? {
        return model.secondAnswer[row]
    }
    
    func getThirdAnswers(for row: Int) -> String? {
        return model.thirdAnswer[row]
    }
}


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
    
    private let viewModel: SettingViewModel
    
    private let firstPickerView = UIPickerView()
    private let secondPickerView = UIPickerView()
    private let thirdPickerView = UIPickerView()
    
    init?(coder: NSCoder, viewModel: SettingViewModel = SettingViewModel()) {
        self.viewModel = viewModel
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
        secondHardcodeAnswerTextField.inputView = secondPickerView
        thirdHardcodeAnswerTextField.inputView = thirdPickerView
        
        presentFirstLabel.textColor = .whiteColor
        presentSecondLabel.textColor = .whiteColor
        presentThirdLabel.textColor = .whiteColor
        
        viewModel.viewLoaded()
        
        viewModel.updateData = { [weak self] fields in
            self?.firstHardcodeAnswerTextField.text = fields.first
            self?.secondHardcodeAnswerTextField.text = fields.second
            self?.thirdHardcodeAnswerTextField.text = fields.third
            
        }
    }
}

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == firstPickerView {
            return viewModel.getFirstAnswerNum()
        } else if pickerView == secondPickerView {
            return viewModel.getSecondAnswerNum()
        } else if pickerView == thirdPickerView {
            return viewModel.getThirdAnswerNum()
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstPickerView {
            return viewModel.getFirstAnswers(for: row)
        } else if pickerView == secondPickerView {
            return viewModel.getSecondAnswers(for: row)
        } else if pickerView == thirdPickerView {
            return viewModel.getThirdAnswers(for: row)
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == firstPickerView {
            firstHardcodeAnswerTextField.text = viewModel.getFirstAnswers(for: row)
        } else if pickerView == secondPickerView {
            secondHardcodeAnswerTextField.text = viewModel.getSecondAnswers(for: row)
        } else if pickerView == thirdPickerView {
            thirdHardcodeAnswerTextField.text = viewModel.getThirdAnswers(for: row)
        }
        self.view.endEditing(false)
    }
}
