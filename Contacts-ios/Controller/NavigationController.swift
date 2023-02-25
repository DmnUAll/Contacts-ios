import UIKit

// MARK: - NavigationController
final class NavigationController: UINavigationController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension NavigationController {
    
    @objc private func sortingButtonTapped() {
        print(#function)
    }
    
    @objc private func filterButtonTapped() {
        print(#function)
    }
    
    private func configureNavigationController() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .ypFullBlack
        navigationBar.tintColor = .ypWhite

        let titleLabel = UICreator.shared.makeLabel(font: UIFont.appFont(.bold, withSize: 34), alignment: .left)
        titleLabel.text = "Контакты"

        let sortingButton = UICreator.shared.makeButton(image: UIImage(named: K.IconsNames.sortingIcon), action: #selector(sortingButtonTapped))
        let filterButton = UICreator.shared.makeButton(image: UIImage(named: K.IconsNames.filterIcon), action: #selector(filterButtonTapped))
        
        let hStack = UICreator.shared.makeStackView(alignment: .center)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(sortingButton)
        hStack.addArrangedSubview(filterButton)
        hStack.spacing = 21
        hStack.alignment = .center
        
        NSLayoutConstraint.activate([
            hStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        navigationBar.topItem?.titleView = hStack
    }
}
