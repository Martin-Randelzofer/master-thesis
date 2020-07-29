import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func initk07ab(_ sender: UIButton) {
        resultText.text = "Started init a + b"
        
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: "file2", relativeTo: directoryURL)

        do {
            let data = NSDataAsset(name: "file2")?.data
            try data?.write(to: fileURL)
            resultText.text = "Finished init a+b, wrote \(data?.count ?? 0) bytes to /file2"
            
        }catch {
            resultText.text = "Error saving file"
        }
        
        
    }
    
    @IBAction func initk07c(_ sender: UIButton) {
        resultText.text = "Started init c"
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            var data = NSDataAsset(name: "file3")?.data
            
            for i in 1...100{
                let fileURL = URL(fileURLWithPath: "file3_\(i)", relativeTo: directoryURL)
                data?.replaceSubrange(1...4, with: [UInt8(i),UInt8(i+1),UInt8(i+2),UInt8(i+3)])
                try data?.write(to: fileURL)
            }
            resultText.text = "Finished init K07c"
            
        }catch {
            resultText.text = "Error saving file"
        }
        
    }
    
    
    @IBAction func startk07a(_ sender: UIButton) {
        resultText.text = "Started a"
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: "file2", relativeTo: directoryURL)
        do {
            let start = DispatchTime.now()
            let savedData = try Data(contentsOf: fileURL)
            let end = DispatchTime.now()
            resultText.text = "\(savedData.count) bytes read successfully, took \((end.uptimeNanoseconds-start.uptimeNanoseconds)/1000000) ms"
            
        } catch {
            resultText.text = "Unable to read the file"
        }
    }
    
    @IBAction func startk07b(_ sender: UIButton) {
        resultText.text = "Started b"
        
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURLRead = URL(fileURLWithPath: "file2", relativeTo: directoryURL)
        do {
            let savedData = try Data(contentsOf: fileURLRead)
            resultText.text = "\(savedData.count) bytes read successfully, wait 2s before writing"
            
            sleep(2)
            let start = DispatchTime.now()
            let fileURLWrite = URL(fileURLWithPath: "fileToWrote", relativeTo: directoryURL)
            try savedData.write(to: fileURLWrite)
            let end = DispatchTime.now()
            resultText.text = "Finished K07b, wrote \(savedData.count) bytes, took \((end.uptimeNanoseconds-start.uptimeNanoseconds)/1000000) ms"
            
        } catch {
            resultText.text = "Unable to read or write the file"
        }
        
    }
    
    @IBAction func startk07c(_ sender: UIButton) {
        resultText.text = "Started c"
        
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let start = DispatchTime.now()
            for i in 1...100{
                let fileURL = URL(fileURLWithPath: "file3_\(i)", relativeTo: directoryURL)
                _ = try Data(contentsOf: fileURL)
            }
            
            let end = DispatchTime.now()
            resultText.text = "Finished K07C, took \((end.uptimeNanoseconds-start.uptimeNanoseconds)/1000000) ms"
            
        } catch {
            resultText.text = "Unable to read the file"
        }
    }
    
    
    
}

