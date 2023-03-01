import UIKit

// MARK: - SplashPresenter
final class SplashPresenter {

    // MARK: - Properties and Initialisers
    private weak var viewController: SplashController?
    private let contactsManager: ContactsAccessAndLoadingProtocol = ContactsManager()

    init(viewController: SplashController? = nil) {
        self.viewController = viewController
        contactsManager.requestAccess { [weak self] isGranted in
            guard let self else { return }
            guard isGranted else {
                viewController?.accessDenied()
                return
            }
            self.loadContacts()
        }
    }
}

// MARK: - Helpers
extension SplashPresenter {

    private func loadContacts() {
        contactsManager.loadContacts(withName: "") { contacts in
            DispatchQueue.main.async {
                let nextVC = NavigationController(
                    rootViewController: ContactsListController(withContactsList: contacts))
                UIApplication.shared.windows.first?.rootViewController = nextVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
}
