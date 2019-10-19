import Foundation
import UIKit

public protocol Coordinator {
    var nav: UINavigationController { get }
    func start()
    func back()
}
