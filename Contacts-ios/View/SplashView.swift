import UIKit

// MARK: - SplashViewProtocol protocol
protocol SplashViewProtocol: AnyObject {
    func proceedToSettings()
}

// MARK: - SplashView
final class SplashView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: SplashViewProtocol?

    private let logoIcon: UIImageView = UICreator.shared.makeImageView(
        withImage: UIImage(named: K.IconsNames.practicumIcon)
    )
    let accessSettingsButton: UIButton = UICreator.shared.makeButton(
        withTitle: "Хочу увидеть свои контакты",
        backgroundColor: .ypBlue,
        cornerRadius: 24,
        action: #selector(accessSettingsButtonTapped)
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        activateAutoLauout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension SplashView {

    @objc private func accessSettingsButtonTapped() {
        delegate?.proceedToSettings()
    }

    private func activateAutoLauout() {
        logoIcon.toAutolayout()
        accessSettingsButton.toAutolayout()
        toAutolayout()
    }

    private func addSubviews() {
        addSubview(logoIcon)
        addSubview(accessSettingsButton)
    }

    private func setupConstraints() {
        let constraints = [
            logoIcon.widthAnchor.constraint(equalToConstant: 59),
            logoIcon.heightAnchor.constraint(equalToConstant: 61),
            logoIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            accessSettingsButton.heightAnchor.constraint(equalToConstant: 64),
            accessSettingsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accessSettingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            accessSettingsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -58)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
