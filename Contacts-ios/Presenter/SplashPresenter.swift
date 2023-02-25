import UIKit

final class SplashPresenter {
    
    private weak var viewController: SplashController?
    private let contactsManager: ContactsAccessAndLoadingProtocol = ContactsManager()
    
    init(viewController: SplashController? = nil) {
        self.viewController = viewController
        
        contactsManager.requestAccess { [weak self] isGranted in
            guard let self else { return }
            guard isGranted else {
                // TODO: access request alert
                viewController?.accessDenied()
                return
            }
            self.loadContacts()
        }
    }
}

extension SplashPresenter {
    
    private func loadContacts() {
        contactsManager.loadContacts(withName: "Aaa") { contacts in
            DispatchQueue.main.async {
                let nextVC = NavigationController(rootViewController: ContactsListController(withContactsList: contacts))
                UIApplication.shared.windows.first?.rootViewController = nextVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
}
