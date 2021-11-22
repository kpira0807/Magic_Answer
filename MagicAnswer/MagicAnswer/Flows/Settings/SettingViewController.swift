import UIKit

class SettingViewController: UIViewController {

    private let introLabel = UILabel()

    private let firstHardcodeAnswerTextField = UITextField()
    private let presentFirstLabel = UILabel()
    private let backgroundFirstView = UIView()

    private let secondHardcodeAnswerTextField = UITextField()
    private let presentSecondLabel = UILabel()
    private let backgroundSecondView = UIView()

    private let thirdHardcodeAnswerTextField = UITextField()
    private let presentThirdLabel = UILabel()
    private let backgroundThirdView = UIView()

    private let viewModel: SettingViewModel

    private let firstPickerView = UIPickerView()
    private let secondPickerView = UIPickerView()
    private let thirdPickerView = UIPickerView()

    init?(_ viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = L10n.navigationItemSVC

        firstPickerView.delegate = self
        firstPickerView.dataSource = self

        secondPickerView.delegate = self
        secondPickerView.dataSource = self

        thirdPickerView.delegate = self
        thirdPickerView.dataSource = self

        firstHardcodeAnswerTextField.inputView = firstPickerView
        secondHardcodeAnswerTextField.inputView = secondPickerView
        thirdHardcodeAnswerTextField.inputView = thirdPickerView

        viewModel.viewLoaded()

        viewModel.updateData = { [weak self] fields in
            self?.firstHardcodeAnswerTextField.text = fields.first
            self?.secondHardcodeAnswerTextField.text = fields.second
            self?.thirdHardcodeAnswerTextField.text = fields.third

        }

        view.addSubview(introLabel)
        view.addSubview(backgroundFirstView)
        view.addSubview(backgroundSecondView)
        view.addSubview(backgroundThirdView)

        addSubviewView(for: backgroundFirstView, with: presentFirstLabel, textField: firstHardcodeAnswerTextField)
        addSubviewView(for: backgroundSecondView, with: presentSecondLabel, textField: secondHardcodeAnswerTextField)
        addSubviewView(for: backgroundThirdView, with: presentThirdLabel, textField: thirdHardcodeAnswerTextField)

        presentFirstLabel.text = L10n.presentFirstLabel
        presentSecondLabel.text = L10n.presentSecondLabel
        presentThirdLabel.text = L10n.presentThirdLabel

        backgroundFirstView.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 50).isActive = true

        introLabels()

        backgroundViewBottomAnchor(for: backgroundSecondView, with: backgroundFirstView)
        backgroundViewBottomAnchor(for: backgroundThirdView, with: backgroundSecondView)

        customTextFields(for: firstHardcodeAnswerTextField)
        customTextFields(for: secondHardcodeAnswerTextField)
        customTextFields(for: thirdHardcodeAnswerTextField)

        customLabels(for: presentFirstLabel)
        customLabels(for: presentSecondLabel)
        customLabels(for: presentThirdLabel)

        customViewBackground(for: backgroundFirstView)
        customViewBackground(for: backgroundSecondView)
        customViewBackground(for: backgroundThirdView)

        sizeTextField(for: firstHardcodeAnswerTextField, with: backgroundFirstView)
        sizeTextField(for: secondHardcodeAnswerTextField, with: backgroundSecondView)
        sizeTextField(for: thirdHardcodeAnswerTextField, with: backgroundThirdView)

        sizeLabels(for: presentFirstLabel, with: backgroundFirstView)
        sizeLabels(for: presentSecondLabel, with: backgroundSecondView)
        sizeLabels(for: presentThirdLabel, with: backgroundThirdView)
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

    private func customTextFields(for fields: UITextField) {
        fields.borderStyle = UITextField.BorderStyle.roundedRect
        fields.font = UIFont.init(name: "System", size: 14.0)
        fields.textAlignment = NSTextAlignment.center
        fields.clipsToBounds = true
    }

    private func customLabels(for label: UILabel) {
        label.textColor = Asset.newWhite.color
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.clipsToBounds = true
    }

    private func introLabels() {
        introLabel.translatesAutoresizingMaskIntoConstraints = false

        let size = view.safeAreaLayoutGuide.topAnchor
        introLabel.topAnchor.constraint(equalTo: size, constant: 15).isActive = true
        introLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        introLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        introLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        introLabel.text = """
        No Internet?
        You can choose answers and play offline!
        """
        introLabel.textColor = Asset.newBlue2.color
        introLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        introLabel.numberOfLines = 0
        introLabel.clipsToBounds = true
    }

    private func sizeTextField(for textField: UITextField, with view: UIView) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = L10n.placeholder
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func sizeLabels(for label: UILabel, with view: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    }
    private func customViewBackground(for views: UIView) {
        views.translatesAutoresizingMaskIntoConstraints = false
        views.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        views.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        views.heightAnchor.constraint(equalToConstant: 120).isActive = true

        views.layer.cornerRadius = 10
        views.backgroundColor = Asset.newBlue.color
        views.clipsToBounds = true
    }

    private func backgroundViewBottomAnchor(for view: UIView, with equalTo: UIView) {
        view.topAnchor.constraint(equalTo: equalTo.bottomAnchor, constant: 20).isActive = true
    }

    private func addSubviewView(for view: UIView, with label: UILabel, textField: UITextField) {
        view.addSubview(label)
        view.addSubview(textField)
    }
}
