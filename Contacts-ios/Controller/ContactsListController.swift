import UIKit

// MARK: - ContactsListController
final class ContactsListController: UIViewController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private let contactsListView = ContactsListView()
    private var presenter: ContactsListPresenter?

    convenience init(withContactsList contactsList: [Contact]) {
        self.init()
        presenter = ContactsListPresenter(viewController: self, contactsList: contactsList)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypFullBlack
        addSubviews()
        setupConstraints()
        (navigationController as? NavigationController)?.buttonsDelegate = self
        contactsListView.contactsTableView.dataSource = self
        contactsListView.contactsTableView.delegate = self
    }
}

// MARK: - Helpers
extension ContactsListController {

    private func addSubviews() {
        view.addSubview(contactsListView)
    }

    private func setupConstraints() {
        let constraints = [
            contactsListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contactsListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            contactsListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contactsListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - NavigationControllerButtonsDelegate
extension ContactsListController: NavigationControllerButtonsDelegate {

    func proceedToSortingSettings() {
        let sortingVC = SortingSettingsController(withCurrentSortingKeys: presenter?.giveCurrentSortingKeys() ?? [])
        sortingVC.delegate = self
        present(sortingVC, animated: true)
    }

    func proceedToFilteringSettings() {
        let filteringVC = FilteringSettingsController(withCurrentFilterKeys: presenter?.giveCurrentFilterKeys() ?? [])
        filteringVC.delegate = self
        present(filteringVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ContactsListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.giveContactsAmount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.configureCell(forTableView: tableView, at: indexPath) ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension ContactsListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let removeButton = UIContextualAction(style: .destructive,
                                                     title: "Удалить") { [weak self] _, _, _ in
            guard let self else { return }
            let alertController = UIAlertController(title: "Уверены что хотите удалить контакт?",
                                                    message: nil,
                                                    preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
                self.presenter?.removeContact(at: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { _ in
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
        removeButton.backgroundColor = UIColor.ypRed

        let config = UISwipeActionsConfiguration(actions: [removeButton])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}

// MARK: - FilteringDelegate
extension ContactsListController: FilteringDelegate {

    func proceedFiltering(withKeys keys: [Bool]) {
        guard let button = navigationItem.titleView?.subviews[2] as? UIButton else { return }
        if keys.filter({ $0 == true }).count == 0 {
            button.removeBadge()
        } else {
            button.addBadge()
        }
        presenter?.filterContacts(with: keys)
        contactsListView.contactsTableView.reloadData()
    }
}

// MARK: - SortingDelegate
extension ContactsListController: SortingDelegate {

    func proceedSorting(withKeys keys: [Bool]) {
        guard let button = navigationItem.titleView?.subviews[1] as? UIButton else { return }
        if keys[0] == true {
            button.removeBadge()
        } else {
            button.addBadge()
        }
        presenter?.sortContacts(withKeys: keys)
        contactsListView.contactsTableView.reloadData()
    }
}
