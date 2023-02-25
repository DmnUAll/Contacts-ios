import UIKit

final class ContactsListController: UIViewController {
    
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
        contactsListView.contactsTableView.dataSource = self
        contactsListView.contactsTableView.delegate = self
    }
}

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

extension ContactsListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.giveContactsAmount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.configureCell(forTableView: tableView, at: indexPath) ?? UITableViewCell()
    }
}

extension ContactsListController: UITableViewDelegate {
    
}
