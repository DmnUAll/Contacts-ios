import UIKit

// MARK: - ContactCell
final class ContactCell: UITableViewCell {

    // MARK: - Properties and Initializers
    let contactView: UIView = {
        let uiView = UICreator.shared.makeView(bacgroundColor: .ypBlack)
        uiView.layer.cornerRadius = 24
        uiView.layer.masksToBounds = true
        return uiView
    }()
    var contactImage: UIImageView = UICreator.shared.makeImageView(backgroundColor: .ypGray, cornerRadius: 24)
    var contactNameLabel: UILabel = UICreator.shared.makeLabel(font: UIFont.appFont(.medium, withSize: 30),
                                                               alignment: .left)
    var contactPhoneNumber: UILabel = UICreator.shared.makeLabel(font: UIFont.appFont(.regular, withSize: 12),
                                                                 alignment: .left, color: .ypGray)
    lazy var telegramImage: UIImageView = makeCommunicationIcon(named: K.IconsNames.telegramIcon)
    lazy var whatsAppImage: UIImageView = makeCommunicationIcon(named: K.IconsNames.whatsAppIcon)
    lazy var viberImage: UIImageView = makeCommunicationIcon(named: K.IconsNames.viberIcon)
    lazy var signalImage: UIImageView = makeCommunicationIcon(named: K.IconsNames.signalIcon)
    lazy var threemaImage: UIImageView = makeCommunicationIcon(named: K.IconsNames.threemaIcon)
    lazy var phoneImage: UIImageView = makeCommunicationIcon(named: K.IconsNames.phoneIcon)
    lazy var eMailImage: UIImageView = makeCommunicationIcon(named: K.IconsNames.eMailIcon)
    let iconsStack: UIStackView = UICreator.shared.makeStackView(alignment: .leading, addingSpacing: -3)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        activateAutoLauout()
        addSubviews()
        setupConstraints()
        contactNameLabel.baselineAdjustment = .alignBaselines
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Helpers
extension ContactCell {

    private func activateAutoLauout() {
        contactView.toAutolayout()
        contactImage.toAutolayout()
        contactNameLabel.toAutolayout()
        contactPhoneNumber.toAutolayout()
        iconsStack.toAutolayout()
    }

    private func addSubviews() {
        contactView.addSubview(contactImage)
        contactView.addSubview(contactNameLabel)
        contactView.addSubview(contactPhoneNumber)
        iconsStack.addArrangedSubview(telegramImage)
        iconsStack.addArrangedSubview(whatsAppImage)
        iconsStack.addArrangedSubview(viberImage)
        iconsStack.addArrangedSubview(signalImage)
        iconsStack.addArrangedSubview(threemaImage)
        iconsStack.addArrangedSubview(phoneImage)
        iconsStack.addArrangedSubview(eMailImage)
        iconsStack.subviews.forEach { icon in
            iconsStack.sendSubviewToBack(icon)
        }
        contactView.addSubview(iconsStack)
        addSubview(contactView)
    }

    private func setupConstraints() {
        let constraints = [
            contactView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contactView.topAnchor.constraint(equalTo: topAnchor),
            contactView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contactView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            contactImage.widthAnchor.constraint(equalToConstant: 96),
            contactImage.heightAnchor.constraint(equalTo: contactImage.widthAnchor, multiplier: 1),
            contactImage.leadingAnchor.constraint(equalTo: contactView.leadingAnchor, constant: 12),
            contactImage.topAnchor.constraint(equalTo: contactView.topAnchor, constant: 12),
            contactImage.bottomAnchor.constraint(equalTo: contactView.bottomAnchor, constant: -12),
            contactNameLabel.heightAnchor.constraint(equalToConstant: 30),
            contactNameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 12),
            contactNameLabel.topAnchor.constraint(equalTo: contactView.topAnchor, constant: 12),
            contactNameLabel.trailingAnchor.constraint(equalTo: contactView.trailingAnchor, constant: -12),
            contactPhoneNumber.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 12),
            contactPhoneNumber.topAnchor.constraint(equalTo: contactNameLabel.bottomAnchor, constant: 12),
            contactPhoneNumber.trailingAnchor.constraint(equalTo: contactView.trailingAnchor, constant: -12),
            iconsStack.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 12),
            iconsStack.topAnchor.constraint(equalTo: contactPhoneNumber.bottomAnchor, constant: 16),
            iconsStack.trailingAnchor.constraint(lessThanOrEqualTo: contactView.trailingAnchor, constant: -12),
            iconsStack.bottomAnchor.constraint(equalTo: contactView.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeCommunicationIcon(named name: String) -> UIImageView {
        let icon = UICreator.shared.makeImageView(withImage: UIImage(named: name),
                                                  cornerRadius: 12,
                                                  borderWidth: 2,
                                                  isHidden: true)
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor, multiplier: 1)
        ])
        return icon
    }
}
