import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"
    
    private let historyImageView: UIImageView = {
        let image = UIImageView()
        image.image = Asset.ball.image
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let historyAnswerLabel: UILabel = {
        let labelAnswer = UILabel()
        labelAnswer.textColor = Asset.newBlue2.color
        labelAnswer.font = .systemFont(ofSize: 15.0, weight: .medium)
        labelAnswer.numberOfLines = 0
        return labelAnswer
    }()
    
    private let historyTimeLabel: UILabel = {
        let labelTime = UILabel()
        labelTime.textColor = Asset.newBlue2.color
        labelTime.font = .systemFont(ofSize: 13.0, weight: .medium)
        labelTime.textAlignment = .right
        labelTime.numberOfLines = 0
        return labelTime
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(historyImageView)
        contentView.addSubview(historyAnswerLabel)
        contentView.addSubview(historyTimeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(history: String, data: String, imageName: UIImage) {
        historyAnswerLabel.text = history
        historyTimeLabel.text = data
        historyImageView.image = imageName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        historyAnswerLabel.text = nil
        historyTimeLabel.text = nil
        historyImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customSizeImage(image: historyImageView)
        customSizeAnswerLabel(label: historyAnswerLabel)
        customSizeDataLabel(data: historyTimeLabel)
    }
}

extension HistoryTableViewCell {
    func customSizeImage(image: UIImageView) {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func customSizeAnswerLabel(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: historyImageView.rightAnchor, constant: 15).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func customSizeDataLabel(data: UILabel) {
        data.translatesAutoresizingMaskIntoConstraints = false
        data.leftAnchor.constraint(equalTo: historyAnswerLabel.rightAnchor, constant: 10).isActive = true
        data.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        data.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
