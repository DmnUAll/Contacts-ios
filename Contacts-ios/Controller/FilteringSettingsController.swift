import UIKit

protocol FilteringDelegate: AnyObject {
    func proceedFiltering(withKeys keys: [Bool])
}

final class FilteringSettingsController: UIViewController {
    
    private let filteringSettingsView = FilteringSettingsView()
    weak var delegate: FilteringDelegate?
    private var givenKeys: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypFullBlack
        addSubviews()
        setupConstraints()
        filteringSettingsView.delegate = self
    }
    
    convenience init(withCurrentFilterKeys keys: [Bool]) {
        self.init()
        givenKeys = keys
        for index in 0..<keys.count {
            if keys[index] {
                filteringSettingsView.checkboxesCollection[index].image = UIImage(named: K.IconsNames.selectedCheckboxIcon)
            }
        }
    }
}

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

extension FilteringSettingsController: FilteringSettingsViewProtocol {
    
    func updateCheckboxState(forTag tag: Int) {
        let checkboxes = filteringSettingsView.checkboxesCollection
        if tag == 0 {
            if checkboxes[0].image == UIImage(named: K.IconsNames.selectedCheckboxIcon) {
                checkboxes.forEach { checkbox in
                    checkbox.image = UIImage(named: K.IconsNames.deselectedCheckboxIcon)
                }
            } else {
                checkboxes.forEach { checkbox in
                    checkbox.image = UIImage(named: K.IconsNames.selectedCheckboxIcon)
                }
            }
        } else if tag > 0 {
            if checkboxes[tag].image == UIImage(named: K.IconsNames.selectedCheckboxIcon) {
                checkboxes[tag].image = UIImage(named: K.IconsNames.deselectedCheckboxIcon)
            } else {
                checkboxes[tag].image = UIImage(named: K.IconsNames.selectedCheckboxIcon)
            }
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
