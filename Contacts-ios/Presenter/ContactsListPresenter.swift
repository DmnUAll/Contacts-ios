import UIKit

final class ContactsListPresenter {
    
    private weak var viewController: ContactsListController?
    private var contactsList: [Contact] = []
    private var editableContactsList: [Contact] = []
    private var currentFilterKeys: [Bool] = [false, false, false, false, false, false, false, false]
    private var currentSortingKeys: [Bool] = [true, false, false, false]
    
    init(viewController: ContactsListController? = nil, contactsList: [Contact]) {
        self.viewController = viewController
        self.contactsList = contactsList
        self.editableContactsList = contactsList
        sortContacts(withKeys: currentSortingKeys)
    }
}

extension ContactsListPresenter {
    
    
    func giveContactsAmount() -> Int {
        return editableContactsList.count
    }

    func configureCell(forTableView tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.contactCell) as? ContactCell else {
            return UITableViewCell()
        }
        let contact = editableContactsList[indexPath.row]
        cell.contactNameLabel.text = "\(contact.name ?? "")"
        cell.contactPhoneNumber.text = "\(contact.phone ?? "")"
        cell.telegramImage.isHidden = contact.telegramUsername == nil
        cell.whatsAppImage.isHidden = contact.whatsAppUsername == nil
        cell.viberImage.isHidden = contact.viberUsername == nil
        cell.signalImage.isHidden = contact.signalUsername == nil
        cell.threemaImage.isHidden = contact.threemaUsername == nil
        cell.phoneImage.isHidden = contact.phone == nil
        cell.eMailImage.isHidden = contact.eMail == nil
        
        if let imageData = editableContactsList[indexPath.row].image {
            cell.contactImage.image = UIImage(data: imageData)
            cell.contactImage.contentMode = .scaleAspectFill
        } else {
            cell.contactImage.image = UIImage(named: K.IconsNames.noImageIcon)
            cell.contactImage.contentMode = .center
        }
        return cell
    }
    
    func removeContact(at indexPath: IndexPath) {
        editableContactsList.remove(at: indexPath.row)
    }
    
    func filterContacts(with keys: [Bool]) {
        currentFilterKeys = keys
        if keys[0] == true || keys.filter({ $0 == true }).count == 0 {
            editableContactsList = contactsList
            return
        }
        var filterResult: [Contact] = []
        for index in 1..<keys.count {
            if keys[index] == true {
                filterResult.append(contentsOf: addContactsToList(forKey: index))
            }
        }
        editableContactsList = Array(Set(filterResult))
    }
    
    func giveCurrentFilterKeys() -> [Bool] {
        currentFilterKeys
    }
    
    private func addContactsToList(forKey key: Int) -> [Contact] {
        switch key {
        case 1:
            return contactsList.filter { $0.telegramUsername != nil }
        case 2:
            return contactsList.filter { $0.whatsAppUsername != nil }
        case 3:
            return contactsList.filter { $0.viberUsername != nil }
        case 4:
            return contactsList.filter { $0.signalUsername != nil }
        case 5:
            return contactsList.filter { $0.threemaUsername != nil }
        case 6:
            return contactsList.filter { $0.phone != nil }
        case 7:
            return contactsList.filter { $0.eMail != nil }
        default:
            return []
        }
    }
    
    func giveCurrentSortingKeys() -> [Bool] {
        currentSortingKeys
    }
    
    func sortContacts(withKeys keys: [Bool]) {
        currentSortingKeys = keys
        let sortingKey = keys.firstIndex(of: true)
        switch sortingKey {
        case 0:
            editableContactsList.sort { ($0.firstName ?? "") < ($1.firstName ?? "") }
        case 1:
            editableContactsList.sort { ($0.firstName ?? "") > ($1.firstName ?? "") }
        case 2:
            editableContactsList.sort { ($0.surname ?? "") < ($1.surname ?? "") }
        case 3:
            editableContactsList.sort { ($0.surname ?? "") > ($1.surname ?? "") }
        default:
            editableContactsList.sort { ($0.firstName ?? "") < ($1.firstName ?? "") }
        }
    }
}
