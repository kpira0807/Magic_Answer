import UIKit

class IntroViewController: UIViewController {
    
    private let introLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = L10n.intro
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.newBlack.color]
        
        customImage()
        customShakeLabel()
    }
}

extension IntroViewController {
    
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
        introLabel.text = L10n.introLabel
        view.addSubview(introLabel)
        
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        introLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        introLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        introLabel.textAlignment = NSTextAlignment.center
        introLabel.textColor = Asset.newBlue2.color
        introLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        introLabel.numberOfLines = 0
        introLabel.clipsToBounds = true
    }
}
