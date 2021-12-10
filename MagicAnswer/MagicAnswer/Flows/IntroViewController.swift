import UIKit

class IntroViewController: UIViewController {
    
    private let introLabel = UILabel()
    private let imageView = UIImageView(image: Asset.ball.image)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = L10n.intro
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.newBlack.color]
        
        customImage()
        customShakeLabel()
        animationLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationImage()
    }
}

extension IntroViewController {
    
    private func customImage() {
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
        introLabel.alpha = 0
        introLabel.textColor = Asset.newBlue2.color
        introLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        introLabel.numberOfLines = 0
        introLabel.clipsToBounds = true
    }
    
    private func animationLabel() {
        UIView.animate(withDuration: 3) {
            self.introLabel.alpha = 1
            self.introLabel.frame.origin.y = 20
        }
    }
    
    private func animationImage() {
        let imageShakeAnimation = CABasicAnimation(keyPath: "position")
        imageShakeAnimation.duration = 1
        imageShakeAnimation.repeatDuration = .infinity
        imageShakeAnimation.autoreverses = true
        imageShakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: imageView.center.y - 10))
        imageShakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: imageView.center.y + 10))
        imageView.layer.add(imageShakeAnimation, forKey: "position")
    }
}
