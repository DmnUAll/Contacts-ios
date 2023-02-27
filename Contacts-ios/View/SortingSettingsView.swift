import UIKit

protocol SortingSettingsViewProtocol: AnyObject {
    func cancelSorting()
    func applySorting()
    func updateRadioButtonState(forTag tag: Int)
}

final class SortingSettingsView: UIView {
    
    weak var delegate: SortingSettingsViewProtocol?
    
    lazy var nameAZButton: UIImageView = makeRadioButton(withTag: 0)
    lazy var nameZAButton: UIImageView  = makeRadioButton(withTag: 1)
    lazy var surnameAZButton: UIImageView  = makeRadioButton(withTag: 2)
    lazy var surnameZAButton: UIImageView  = makeRadioButton(withTag: 3)

    var radioButtonsCollection: [UIImageView] {
        [
            nameAZButton,
            nameZAButton,
            surnameAZButton,
            surnameZAButton
        ]
    }
    
    private let resetButton: UIButton  = UICreator.shared.makeButton(withTitle: "Сбросить", cornerRadius: 24, action: #selector(resetButtonTapped))
    let applyButton: UIButton  = UICreator.shared.makeButton(withTitle: "Применить", backgroundColor: .ypGray, cornerRadius: 24, action: #selector(applyButtonTapped))

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

extension SortingSettingsView {
    
    @objc private func changeRadioButtonState(sender: UIButton) {
        delegate?.updateRadioButtonState(forTag: sender.tag)
    }
    
    @objc private func resetButtonTapped() {
        delegate?.cancelSorting()
    }
    
    @objc private func applyButtonTapped() {
        delegate?.applySorting()
    }
    
    private func activateAutoLauout() {
        settingsStackView.toAutolayout()
        resetButton.toAutolayout()
        applyButton.toAutolayout()
        toAutolayout()
    }
    
    private func addSubviews() {
        settingsStackView.addArrangedSubview(makeSettingsView(withText: UICreator.shared.makeLabel(text: "По имени (А-Я / A-Z)", alignment: .left),
                                                              andRadioButton: nameAZButton))
        settingsStackView.addArrangedSubview(makeSettingsView(withText: UICreator.shared.makeLabel(text: "По имени (Я-А / Z-A)", alignment: .left),
                                                              andRadioButton: nameZAButton))
        settingsStackView.addArrangedSubview(makeSettingsView(withText: UICreator.shared.makeLabel(text: "По фамилии (А-Я / A-Z)", alignment: .left),
                                                              andRadioButton: surnameAZButton))
        settingsStackView.addArrangedSubview(makeSettingsView(withText: UICreator.shared.makeLabel(text: "По фамилии (Я-А / Z-A)", alignment: .left),
                                                              andRadioButton: surnameZAButton))
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
            settingsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            settingsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 46),
            settingsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func makeRadioButton(withTag tag: Int) -> UIImageView {
        let imageView = UICreator.shared.makeImageView(withImage: UIImage(named: K.IconsNames.deselectedRadioButtonIcon))
        imageView.toAutolayout()
        imageView.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 22),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
        ])
        let button = UIButton()
        button.toAutolayout()
        button.tag = tag
        button.frame = imageView.frame
        button.addTarget(self, action: #selector(changeRadioButtonState), for: .touchUpInside)
        imageView.addSubview(button)
        return imageView
    }
    
    private func makeSettingsView(withText text: UILabel, andRadioButton radioButton: UIImageView) -> UIView {
        let uiView = UICreator.shared.makeView(bacgroundColor: .ypBlack)
        text.toAutolayout()
        uiView.layer.cornerRadius = 24
        uiView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            uiView.heightAnchor.constraint(equalToConstant: 64)
        ])
        uiView.addSubview(text)
        uiView.addSubview(radioButton)
        NSLayoutConstraint.activate([
            radioButton.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -17),
            radioButton.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 16),
            text.centerYAnchor.constraint(equalTo: uiView.centerYAnchor)
        ])
        return uiView
    }
}
