import UIKit

// MARK: - ContactsListView
final class ContactsListView: UIView {

    // MARK: - Properties and Initializers
    let contactsTableView: UITableView = UICreator.shared.makeTableView(
        withCells: (type: ContactCell.self, identifier: K.CellIdentifiers.contactCell)
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
extension ContactsListView {

    private func activateAutoLauout() {
        contactsTableView.toAutolayout()
        toAutolayout()
    }

    private func addSubviews() {
        addSubview(contactsTableView)
    }

    private func setupConstraints() {
        let constraints = [
            contactsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contactsTableView.topAnchor.constraint(equalTo: topAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
