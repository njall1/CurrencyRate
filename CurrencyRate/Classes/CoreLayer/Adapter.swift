//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

protocol ReusableView: class {

    static var reuseIdentifier: String { get }
}

extension ReusableView {

    static var reuseIdentifier: String { return NSStringFromClass(self) }
}

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}

protocol CellConfiguratorType {

    func configurateCell(with model: Any, in tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell

    func supports(type: Any.Type) -> Bool

    func register(in tableView: UITableView)
}

class BasicCellConfigurator<ViewModel, Cell: UITableViewCell>: CellConfiguratorType where Cell: ReusableView {

    typealias Configuration = (ViewModel, Cell, IndexPath, UITableView) -> Void

    private let configuration: Configuration

    init(configuration: @escaping Configuration) {
        self.configuration = configuration
    }

    // MARK: - CellProviderType
    func configurateCell(with model: Any, in tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let typedModel: ViewModel = typedViewModel(model)

        configuration(typedModel, cell, indexPath, tableView)

        return cell
    }

    func supports(type: Any.Type) -> Bool {
        return type == ViewModel.self
    }

    func register(in tableView: UITableView) {
        tableView.register(Cell.self)
    }

    // MARK: - Private
    private func typedViewModel(_ viewModel: Any) -> ViewModel {
        guard let item: ViewModel = viewModel as? ViewModel else {
            fatalError("[CellProvider] can not cast `\(type(of: viewModel))` to `\(ViewModel.self)` type")
        }
        return item
    }
}


struct Provider { let name: String }
struct ProviderInfo { let specialty: String; let city: String }

class ProviderCell: UITableViewCell, ReusableView {

    static func providerCellConfigurator() -> BasicCellConfigurator<Provider, ProviderCell> {
        return BasicCellConfigurator<Provider, ProviderCell>(configuration: { (model: Provider, cell: ProviderCell, _, _) in
            cell.textLabel?.text = model.name
        })
    }
}

class ProviderInfoCell: UITableViewCell, ReusableView {

    static func providerInfoCellConfigurator() -> BasicCellConfigurator<ProviderInfo, ProviderInfoCell> {
        return BasicCellConfigurator<ProviderInfo, ProviderInfoCell>(configuration: { (model: ProviderInfo, cell: ProviderInfoCell, _, _) in
            cell.textLabel?.text = "\(model.specialty) in \(model.city)"
        })
    }
}

class AggregatedCellConfigurator: CellConfiguratorType {

    private let configurators: [CellConfiguratorType]

    init(configurators: [CellConfiguratorType]) {
        self.configurators = configurators
    }

    func configurateCell(with model: Any, in tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        return getConfigurator(for: model).configurateCell(with: model, in: tableView, atIndexPath: indexPath)
    }

    func supports(type: Any.Type) -> Bool {
        return configurators.contains(where: { $0.supports(type: type) })
    }

    func register(in tableView: UITableView) {
        configurators.forEach { $0.register(in: tableView) }
    }

    func getConfigurator(for model: Any) -> CellConfiguratorType {
        let modelType = type(of: model)
        guard let configurator: CellConfiguratorType = configurators.first(where: { $0.supports(type: modelType) }) else {
            fatalError("There is not registered configurator for `\(modelType)` type")
        }

        return configurator
    }
}

struct Section<ModelType> {
    var items: [ModelType] = []
}

enum MedicaProviderListProps {
    case header(Provider)
    case info(ProviderInfo)
}

class Adapter<ItemType>: NSObject, UITableViewDataSource, UITableViewDelegate {

    let cellConfigurator: CellConfiguratorType
    var sections: [Section<ItemType>] = []
    var isRegistered: Bool = false

    init(cellConfigurator: CellConfiguratorType) {
        self.cellConfigurator = cellConfigurator
    }

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isRegistered {
            cellConfigurator.register(in: tableView)
            isRegistered = true
        }

        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = getItem(at: indexPath)
        return getConfigurator(for: model).configurateCell(with: model, in: tableView, atIndexPath: indexPath)
    }

    public func getConfigurator(for model: Any) -> CellConfiguratorType {
        if let cellConfigurator = cellConfigurator as? AggregatedCellConfigurator {
            return cellConfigurator.getConfigurator(for: model)
        }

        return cellConfigurator
    }

    public func getItem(at indexPath: IndexPath) -> Any {
        return sections[indexPath.section].items[indexPath.item]
    }

    public func typedModel<T>(from model: Any) -> T {
        guard let typedItem = model as? T else { fatalError("Can not cast \(type(of: model)) to \(T.self)") }

        return typedItem
    }
}

class ProviderAdapter: Adapter<MedicaProviderListProps> {

    override func getItem(at indexPath: IndexPath) -> Any {
        let item = super.getItem(at: indexPath)
        let typedItem: MedicaProviderListProps = typedModel(from: item)

        switch typedItem {
        case .header(let provider): return provider
        case .info(let providerInfo): return providerInfo
        }
    }
}

class MyViewController : UIViewController {
    private let tableView: UITableView = UITableView(frame: .zero, style: .plain)
    private let adapter = ProviderAdapter(cellConfigurator: AggregatedCellConfigurator(
        configurators: [
            ProviderCell.providerCellConfigurator(),
            ProviderInfoCell.providerInfoCellConfigurator()
        ])
    )

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        tableView.dataSource = adapter
        view.addSubview(tableView)

        adapter.sections = [
            .init(items: [
                .header(.init(name: "John")),
                .info(.init(specialty: "Cardilogist", city: "New York"))
            ])
        ]
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
