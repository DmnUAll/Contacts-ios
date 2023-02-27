import UIKit

protocol SortingDelegate: AnyObject {
    func proceedSorting(withKeys keys: [Bool])
}

final class SortingSettingsController: UIViewController {
    
    private let sortingSettingsView = SortingSettingsView()
    weak var delegate: SortingDelegate?
    private var givenKeys: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypFullBlack
        addSubviews()
        setupConstraints()
        sortingSettingsView.delegate = self
    }
    
    convenience init(withCurrentSortingKeys keys: [Bool]) {
        self.init()
        givenKeys = keys
        updateRadioButtonState(forTag: keys.firstIndex(of: true) ?? 0)
    }
}

extension SortingSettingsController {
    
    private func addSubviews() {
        view.addSubview(sortingSettingsView)
    }
    
    private func setupConstraints() {
        let constraints = [
            sortingSettingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sortingSettingsView.topAnchor.constraint(equalTo: view.topAnchor),
            sortingSettingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sortingSettingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func activateApplyButtonIfNeeded() {
        let selectedImage = UIImage(named: K.IconsNames.selectedRadioButtonIcon)
        let keysToCompare = sortingSettingsView.radioButtonsCollection.map {$0.image == selectedImage ? true : false}
        if givenKeys == keysToCompare {
            sortingSettingsView.applyButton.backgroundColor = .ypGray
        } else {
            sortingSettingsView.applyButton.backgroundColor = .ypBlue
        }
    }
}

extension SortingSettingsController: SortingSettingsViewProtocol {
    
    func updateRadioButtonState(forTag tag: Int) {
        var radioButtons = sortingSettingsView.radioButtonsCollection
        radioButtons[tag].image = UIImage(named: K.IconsNames.selectedRadioButtonIcon)
        radioButtons.remove(at: tag)
        radioButtons.forEach { radioButton in
            radioButton.image = UIImage(named: K.IconsNames.deselectedRadioButtonIcon)
        }
        activateApplyButtonIfNeeded()
    }
    
    func cancelSorting() {
        sortingSettingsView.radioButtonsCollection.forEach { radioButton in
            radioButton.image = UIImage(named: K.IconsNames.deselectedRadioButtonIcon)
        }
        sortingSettingsView.radioButtonsCollection[0].image = UIImage(named: K.IconsNames.selectedRadioButtonIcon)
        activateApplyButtonIfNeeded()
    }
    
    func applySorting() {
        let selectedImage = UIImage(named: K.IconsNames.selectedRadioButtonIcon)
        let keys = sortingSettingsView.radioButtonsCollection.map {$0.image == selectedImage ? true : false}
        delegate?.proceedSorting(withKeys: keys)
        dismiss(animated: true)
    }
}
