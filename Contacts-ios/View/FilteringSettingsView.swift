import UIKit

// MARK: - FilteringSettingsViewProtocol protocol
protocol FilteringSettingsViewProtocol: AnyObject {
    func updateCheckboxState(forTag tag: Int)
    func cancelFiltering()
    func applyFiltering()
}

// MARK: - FilteringSettingsView
final class FilteringSettingsView: UIView {

    weak var delegate: FilteringSettingsViewProtocol?

    lazy var selectAllCheckbox: UIImageView = makeCheckbox(withTag: 0)
    lazy var telegramCheckbox: UIImageView  = makeCheckbox(withTag: 1)
    lazy var whatsAppCheckbox: UIImageView  = makeCheckbox(withTag: 2)
    lazy var viberCheckbox: UIImageView  = makeCheckbox(withTag: 3)
    lazy var signalCheckbox: UIImageView  = makeCheckbox(withTag: 4)
    lazy var threemaCheckbox: UIImageView  = makeCheckbox(withTag: 5)
    lazy var phoneCheckbox: UIImageView  = makeCheckbox(withTag: 6)
    lazy var emailCheckbox: UIImageView  = makeCheckbox(withTag: 7)

    var checkboxesCollection: [UIImageView] {
        [
            selectAllCheckbox,
            telegramCheckbox,
            whatsAppCheckbox,
            viberCheckbox,
            signalCheckbox,
            threemaCheckbox,
            phoneCheckbox,
            emailCheckbox
        ]
    }

    private let resetButton: UIButton  = UICreator.shared.makeButton(withTitle: "Сбросить",
                                                                     cornerRadius: 24,
                                                                     action: #selector(resetButtonTapped))
    let applyButton: UIButton  = UICreator.shared.makeButton(withTitle: "Применить",
                                                             backgroundColor: .ypGray,
                                                             cornerRadius: 24,
                                                             action: #selector(applyButtonTapped))

    private let settingsStackView: UIStackView = UICreator.shared.makeStackView(axis: .vertical)

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
extension FilteringSettingsView {

    @objc private func changeCheckboxState(sender: UIButton) {
        delegate?.updateCheckboxState(forTag: sender.tag)
    }

    @objc private func resetButtonTapped() {
        delegate?.cancelFiltering()
    }

    @objc private func applyButtonTapped() {
        delegate?.applyFiltering()
    }

    private func activateAutoLauout() {
        settingsStackView.toAutolayout()
        resetButton.toAutolayout()
        applyButton.toAutolayout()
        toAutolayout()
    }

    private func addSubviews() {
        settingsStackView.addArrangedSubview(makeSettingsView(
            text: UICreator.shared.makeLabel(text: "Выбрать все", alignment: .left),
            andCheckbox: selectAllCheckbox))
        settingsStackView.addArrangedSubview(makeSettingsView(
            withImage: makeSettingsIcon(named: K.IconsNames.telegramIcon),
            text: UICreator.shared.makeLabel(text: "Telegram", alignment: .left),
            andCheckbox: telegramCheckbox))
        settingsStackView.addArrangedSubview(makeSettingsView(
            withImage: makeSettingsIcon(named: K.IconsNames.whatsAppIcon),
            text: UICreator.shared.makeLabel(text: "WhatsApp", alignment: .left),
            andCheckbox: whatsAppCheckbox))
        settingsStackView.addArrangedSubview(makeSettingsView(
            withImage: makeSettingsIcon(named: K.IconsNames.viberIcon),
            text: UICreator.shared.makeLabel(text: "Viber", alignment: .left),
            andCheckbox: viberCheckbox))
        settingsStackView.addArrangedSubview(makeSettingsView(
            withImage: makeSettingsIcon(named: K.IconsNames.signalIcon),
            text: UICreator.shared.makeLabel(text: "Signal", alignment: .left),
            andCheckbox: signalCheckbox))
        settingsStackView.addArrangedSubview(makeSettingsView(
            withImage: makeSettingsIcon(named: K.IconsNames.threemaIcon),
            text: UICreator.shared.makeLabel(text: "Threema", alignment: .left),
            andCheckbox: threemaCheckbox))
        settingsStackView.addArrangedSubview(makeSettingsView(
            withImage: makeSettingsIcon(named: K.IconsNames.phoneIcon),
            text: UICreator.shared.makeLabel(text: "Номер телефона", alignment: .left),
            andCheckbox: phoneCheckbox))
        settingsStackView.addArrangedSubview(makeSettingsView(
            withImage: makeSettingsIcon(named: K.IconsNames.eMailIcon),
            text: UICreator.shared.makeLabel(text: "E-mail", alignment: .left),
            andCheckbox: emailCheckbox))
        addSubview(settingsStackView)
        addSubview(resetButton)
        addSubview(applyButton)
    }

    private func setupConstraints() {
        let constraints = [
            resetButton.heightAnchor.constraint(equalToConstant: 64),
            resetButton.widthAnchor.constraint(equalToConstant: 162),
            resetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resetButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -58),
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            applyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -58),
            applyButton.widthAnchor.constraint(equalTo: resetButton.widthAnchor, multiplier: 1),
            applyButton.heightAnchor.constraint(equalTo: resetButton.heightAnchor, multiplier: 1),
            settingsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            settingsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 46),
            settingsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeSettingsIcon(named name: String) -> UIImageView {
        let icon = UICreator.shared.makeImageView(withImage: UIImage(named: name), cornerRadius: 12, borderWidth: 1.5)
        icon.toAutolayout()
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40)
        ])
        return icon
    }

    private func makeCheckbox(withTag tag: Int) -> UIImageView {
        let imageView = UICreator.shared.makeImageView(withImage: UIImage(named: K.IconsNames.deselectedCheckboxIcon))
        imageView.toAutolayout()
        imageView.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
        ])
        let button = UIButton()
        button.toAutolayout()
        button.tag = tag
        button.frame = imageView.frame
        button.addTarget(self, action: #selector(changeCheckboxState), for: .touchUpInside)
        imageView.addSubview(button)
        return imageView
    }

    private func makeSettingsView(withImage image: UIImageView? = nil,
                                  text: UILabel,
                                  andCheckbox checkbox: UIImageView
    ) -> UIView {
        let uiView = UICreator.shared.makeView(bacgroundColor: .ypBlack)
        text.toAutolayout()
        uiView.layer.cornerRadius = 24
        uiView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            uiView.heightAnchor.constraint(equalToConstant: 64)
        ])
        if let image = image {
            uiView.addSubview(image)
            uiView.addSubview(text)
            uiView.addSubview(checkbox)
            NSLayoutConstraint.activate([
                image.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 16),
                image.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
                checkbox.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -18),
                checkbox.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
                text.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
                text.trailingAnchor.constraint(equalTo: checkbox.leadingAnchor, constant: 7),
                text.centerYAnchor.constraint(equalTo: uiView.centerYAnchor)
            ])
            return uiView
        }
        uiView.addSubview(text)
        uiView.addSubview(checkbox)
        NSLayoutConstraint.activate([
            checkbox.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -18),
            checkbox.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 16),
            text.trailingAnchor.constraint(equalTo: checkbox.leadingAnchor, constant: 7),
            text.centerYAnchor.constraint(equalTo: uiView.centerYAnchor)
        ])
        return uiView
    }
}
