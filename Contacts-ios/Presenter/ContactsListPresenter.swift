import UIKit

final class ContactsListPresenter {
    
    private weak var viewController: ContactsListController?
    private var contactsList: [Contact] = []
    
    init(viewController: ContactsListController? = nil, contactsList: [Contact]) {
        self.viewController = viewController
        self.contactsList = contactsList
    }
}

extension ContactsListPresenter {
    
    
    func giveContactsAmount() -> Int {
        return contactsList.count
    }

    func configureCell(forTableView tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.contactCell) as? ContactCell else {
            return UITableViewCell()
        }
        let contact = contactsList[indexPath.row]
        cell.contactNameLabel.text = "\(contact.name)"
        cell.contactPhoneNumber.text = "\(contact.phone)"
        cell.telegramImage.isHidden = contact.telegramUsername == nil
        cell.whatsAppImage.isHidden = contact.whatsAppUsername == nil
        cell.viberImage.isHidden = contact.viberUsername == nil
        cell.signalImage.isHidden = contact.signalUsername == nil
        cell.threemaImage.isHidden = contact.threemaUsername == nil
        cell.phoneImage.isHidden = contact.phone == nil
        cell.eMailImage.isHidden = contact.eMail == nil
        
        if let imageData = contactsList[indexPath.row].image {
            cell.contactImage.image = UIImage(data: imageData)
            cell.contactImage.contentMode = .scaleAspectFill
        } else {
            cell.contactImage.image = UIImage(named: K.IconsNames.noImageIcon)
            cell.contactImage.contentMode = .center
        }
        return cell
    }
}

