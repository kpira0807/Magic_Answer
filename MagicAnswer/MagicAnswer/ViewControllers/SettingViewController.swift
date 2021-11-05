import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var chooseFirstHardcodeAnswer: UITextField!
    @IBOutlet weak var presentFirstLabel: UILabel!
    @IBOutlet weak var backgroundFirstView: CustomViewBackground!
    
    @IBOutlet weak var chooseSecondHardcodeAnswer: UITextField!
    @IBOutlet weak var presentSecondLabel: UILabel!
    @IBOutlet weak var backgroundSecondView: CustomViewBackground!
    
    @IBOutlet weak var chooseThirdHardcodeAnswer: UITextField!
    @IBOutlet weak var presentThirdLabel: UILabel!
    @IBOutlet weak var backgroundThirdView: CustomViewBackground!
    
    let answers = HardcodedAnswers()
    let chooseFirstPickerView = UIPickerView()
    let chooseSecondPickerView = UIPickerView()
    let chooseThirdPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseFirstPickerView.delegate = self
        chooseFirstPickerView.dataSource = self
        
        chooseSecondPickerView.delegate = self
        chooseSecondPickerView.dataSource = self
        
        chooseThirdPickerView.delegate = self
        chooseThirdPickerView.dataSource = self
        
        chooseFirstHardcodeAnswer.inputView = chooseFirstPickerView
        chooseFirstHardcodeAnswer.text = answers.firstArrayAnswers[0]
        UserDefaults.standard.set(answers.firstArrayAnswers[0], forKey: "answer")
        
        chooseSecondHardcodeAnswer.inputView = chooseSecondPickerView
        chooseSecondHardcodeAnswer.text = answers.secondArrayAnswers[0]
        UserDefaults.standard.set(answers.secondArrayAnswers[0], forKey: "answer")
        
        chooseThirdHardcodeAnswer.inputView = chooseThirdPickerView
        chooseThirdHardcodeAnswer.text = answers.thirdArrayAnswers[0]
        UserDefaults.standard.set(answers.thirdArrayAnswers[0], forKey: "answer")
        
        presentFirstLabel.textColor = .whiteColor
        presentSecondLabel.textColor = .whiteColor
        presentThirdLabel.textColor = .whiteColor
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
        let array = [chooseFirstHardcodeAnswer.text, chooseSecondHardcodeAnswer.text, chooseThirdHardcodeAnswer.text]
        print(array)
        UserDefaults.standard.set(array, forKey: "answer")
        self.view.endEditing(false)
    }
}
