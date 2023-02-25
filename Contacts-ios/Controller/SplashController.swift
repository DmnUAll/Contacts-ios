import UIKit

final class SplashController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private let splashView = SplashView()
    private var presenter: SplashPresenter?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypFullBlack
        addSubviews()
        setupConstraints()
        presenter = SplashPresenter(viewController: self)
        splashView.delegate = self
        splashView.accessSettingsButton.isHidden = true
    }
}

extension SplashController {
    
    private func addSubviews() {
        view.addSubview(splashView)
    }
    
    private func setupConstraints() {
        let constraints = [
            splashView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splashView.topAnchor.constraint(equalTo: view.topAnchor),
            splashView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splashView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func accessDenied() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.splashView.accessSettingsButton.isHidden = false
        }
    }
}


extension SplashController: SplashViewProtocol {
    
    func proceedToSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}
