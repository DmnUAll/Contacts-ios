import UIKit

// MARK: - FilteringDelegateProtocol
protocol FilteringDelegate: AnyObject {
    func proceedFiltering(withKeys keys: [Bool])
}

// MARK: - FilteringSettingsController
final class FilteringSettingsController: UIViewController {

    // MARK: - Properties and Initializers
    private let filteringSettingsView = FilteringSettingsView()
    weak var delegate: FilteringDelegate?
    private var givenKeys: [Bool] = []

    convenience init(withCurrentFilterKeys keys: [Bool]) {
        let selelctedCheckbox = UIImage(named: K.IconsNames.selectedCheckboxIcon)
        self.init()
        givenKeys = keys
        for index in 0..<keys.count where keys[index] {
            filteringSettingsView.checkboxesCollection[index].image = selelctedCheckbox
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypFullBlack
        addSubviews()
        setupConstraints()
        filteringSettingsView.delegate = self
    }
}

// MARK: - Helpers
extension FilteringSettingsController {

    private func addSubviews() {
        view.addSubview(filteringSettingsView)
    }

    private func setupConstraints() {
        let constraints = [
            filteringSettingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filteringSettingsView.topAnchor.constraint(equalTo: view.topAnchor),
            filteringSettingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filteringSettingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func activateApplyButtonIfNeeded() {
        let selectedImage = UIImage(named: K.IconsNames.selectedCheckboxIcon)
        let keysToCompare = filteringSettingsView.checkboxesCollection.map {$0.image == selectedImage ? true : false}
        if givenKeys == keysToCompare {
            filteringSettingsView.applyButton.backgroundColor = .ypGray
        } else {
            filteringSettingsView.applyButton.backgroundColor = .ypBlue
        }
    }
}

// MARK: - FilteringSettingsViewProtocol
extension FilteringSettingsController: FilteringSettingsViewProtocol {

    func updateCheckboxState(forTag tag: Int) {
        let selectedCheckbox  = UIImage(named: K.IconsNames.selectedCheckboxIcon)
        let deselectedCheckbox = UIImage(named: K.IconsNames.deselectedCheckboxIcon)
        let checkboxes = filteringSettingsView.checkboxesCollection
        if tag == 0 {
            if checkboxes[0].image == selectedCheckbox {
                checkboxes.forEach { checkbox in
                    checkbox.image = deselectedCheckbox
                }
            } else {
                checkboxes.forEach { checkbox in
                    checkbox.image = selectedCheckbox
                }
            }
        } else if tag > 0 {
            if checkboxes[tag].image == selectedCheckbox {
                checkboxes[tag].image = deselectedCheckbox
            } else {
                checkboxes[tag].image = selectedCheckbox
            }
        }
        if checkboxes[1...7].filter({ $0.image == selectedCheckbox }).count == 7 {
            checkboxes[0].image = selectedCheckbox
        } else {
            checkboxes[0].image = deselectedCheckbox
        }
        activateApplyButtonIfNeeded()
    }

    func cancelFiltering() {
        filteringSettingsView.checkboxesCollection.forEach { checkbox in
            checkbox.image = UIImage(named: K.IconsNames.deselectedCheckboxIcon)
        }
        activateApplyButtonIfNeeded()
    }

    func applyFiltering() {
        let selectedImage = UIImage(named: K.IconsNames.selectedCheckboxIcon)
        let keys = filteringSettingsView.checkboxesCollection.map {$0.image == selectedImage ? true : false}
        delegate?.proceedFiltering(withKeys: keys)
        dismiss(animated: true)
    }
}
