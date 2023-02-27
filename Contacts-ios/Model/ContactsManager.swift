import Foundation
import Contacts

protocol ContactsAccessAndLoadingProtocol: AnyObject {
    func requestAccess(completion: @escaping (Bool) -> Void)
    func loadContacts(withName name: String, completion: @escaping ([Contact]) -> Void)

}

final class ContactsManager {
    
    private let store = CNContactStore()
    private let queue = DispatchQueue(label: K.QueueNames.contactsQueue)
}

extension ContactsManager: ContactsAccessAndLoadingProtocol {
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        store.requestAccess(for: .contacts) { isGranted, error in
            if let error {
                print(error.localizedDescription)
            }
            completion(isGranted)
        }
    }
    
    func loadContacts(withName name: String, completion: @escaping ([Contact]) -> Void) {
        let keys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataKey,
            CNContactEmailAddressesKey,
            CNContactInstantMessageAddressesKey
        ] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        queue.async { [weak self] in
            guard let self else { return }
            do {
                var cnContacts = [CNContact]()
                if name == "" {
                    try self.store.enumerateContacts(with: request) { contact, _ in
                        cnContacts.append(contact)
                    }
                } else {
                    let predicate = CNContact.predicateForContacts(matchingName: name)
                    cnContacts = try self.store.unifiedContacts(matching: predicate, keysToFetch: keys)
                }
                let contacts = cnContacts.map { cnContact in
                    let phoneLabeledValue = cnContact.phoneNumbers.first {
                        $0.label == CNLabelPhoneNumberMobile
                    }
                    let phone = phoneLabeledValue?.value.stringValue
                    
                    let eMailLabeledValue = cnContact.emailAddresses.first {
                        $0.label == K.CNContactLabelKeys.home
                    }
                    let eMail = eMailLabeledValue?.value as? String

                    let telegramLabeledValue = cnContact.instantMessageAddresses.first {
                        $0.label ==  K.CNContactLabelKeys.telegram
                    }
                    let telegramUsername = telegramLabeledValue?.value.username

                    let whatsAppLabeledValue = cnContact.instantMessageAddresses.first {
                        $0.label ==  K.CNContactLabelKeys.whatsApp
                    }
                    let whatsAppUsername = whatsAppLabeledValue?.value.username
                    
                    let viberLabeledValue = cnContact.instantMessageAddresses.first {
                        $0.label ==  K.CNContactLabelKeys.viber
                    }
                    let viberUsername = viberLabeledValue?.value.username
                    
                    let threemaLabeledValue = cnContact.instantMessageAddresses.first {
                        $0.label ==  K.CNContactLabelKeys.threema
                    }
                    let threemaUsername = threemaLabeledValue?.value.username
                    
                    let signalLabeledValue = cnContact.instantMessageAddresses.first {
                        $0.label ==  K.CNContactLabelKeys.signal
                    }
                    let signalUsername = signalLabeledValue?.value.username
                    
                    return Contact(
                        name: "\(cnContact.givenName) \(cnContact.familyName)",
                        firstName: cnContact.givenName,
                        surname: cnContact.familyName,
                        phone: phone,
                        image: cnContact.imageData,
                        eMail: eMail,
                        telegramUsername: telegramUsername,
                        whatsAppUsername: whatsAppUsername,
                        viberUsername: viberUsername,
                        threemaUsername: threemaUsername,
                        signalUsername: signalUsername
                    )
                }
                DispatchQueue.main.async {
                    completion(contacts)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
}
