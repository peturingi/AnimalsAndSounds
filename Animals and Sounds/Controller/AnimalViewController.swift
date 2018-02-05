import UIKit

class AnimalViewController: UIViewController {

    public var animal: Animal?
    public var player: AudioPlayer? { get { return AudioPlayer.sharedInstance } }
    
    override func viewWillAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = animal?.image
        imageView.bounds = self.view.bounds
        imageView.isUserInteractionEnabled = true
                
        self.view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        player!.play(sound: animal!.sound)
    }
    
    @IBAction func close(_ sender: Any) {
        player!.stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
