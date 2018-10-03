import UIKit

protocol PlatformViewControllerDelegate: class {
  func didUpdateCounter(counter: Int)
}

class PlatformViewController: UIViewController {
  weak var delegate: PlatformViewControllerDelegate?

  @IBOutlet weak var incrementLabel: UILabel?

  var counter: Int = 0 {
    didSet {
      setIncrementLabel()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setIncrementLabel()
  }

  @IBAction func handleIncrement(_ sender: UIButton) {
    counter += 1
  }

  @IBAction func switchToFlutterView(_ sender: UIButton) {
    self.delegate?.didUpdateCounter(counter: counter)
    dismiss(animated: false)
  }

  private func setIncrementLabel() {
    let times = counter == 1 ? "time" : "times"
    incrementLabel?.text = "Button tapped \(counter) \(times)"
  }
}
