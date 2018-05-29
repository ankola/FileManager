

import UIKit

class NewViewController: UIViewController {

    var fileManagaer:FileManager?
    var documentDir:NSString?
    var filePath:NSString?
    var fileurl:NSURL?
    
    @IBOutlet var imgview:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       fileManagaer = FileManager.default
        var dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        documentDir = dirPath[0] as NSString
    }
    
    @IBAction func btnCreateFile(sender: UIButton){
        var error:NSError? = nil
        
        filePath = documentDir?.appendingPathComponent("/file.txt") as NSString?
        fileManagaer?.createFile(atPath: filePath as! String, contents: nil, attributes: nil)
        print(filePath)
    }
    
    @IBAction func BtnCreateDirectory(sender: UIButton){
        
        // Create folder
        filePath = documentDir?.appendingPathComponent("/FolderCreated") as! NSString
        do{try fileManagaer?.createDirectory(atPath: filePath! as String, withIntermediateDirectories: false, attributes: nil)
            
            //Create File
            filePath = documentDir?.appendingPathComponent("/FolderCreated/file.txt") as NSString?
            fileManagaer?.createFile(atPath: filePath as! String, contents: nil, attributes: nil)
          print(filePath)
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func btnMoveFile(sender: UIButton){
        var oldfilepath = documentDir?.appendingPathComponent("file.txt")
        var NewFilepath = documentDir?.appendingPathComponent("/FolderCreated/file.txt")
        do{
            try fileManagaer?.moveItem(atPath: oldfilepath!, toPath: NewFilepath!)
            print(NewFilepath)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func btnCopyFile(sender: UIButton){
        
        var originalfile = documentDir?.appendingPathComponent("file.txt")
        var copyfile = documentDir?.appendingPathComponent("/FolderCreated/copyfile.txt")
        do{
            try fileManagaer?.copyItem(atPath: originalfile! as String, toPath: copyfile!)
            print("copypath : \(copyfile)")
            print("origpath : \(originalfile)")
            print("file copy successfully")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func BtnRemove(sender: UIButton){
        filePath = documentDir?.appendingPathComponent("file.txt") as! NSString
        do{
            try fileManagaer?.removeItem(atPath: filePath! as String)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func BtnWrite(sender: UIButton){
        var content:NSString=NSString(string: "helllo how are you?")
        var fileContent:NSData=content.data(using: String.Encoding.utf8.rawValue)! as NSData
        fileContent .write(toFile: documentDir!.appendingPathComponent("file.txt"), atomically: true)
    }
    
    @IBAction func BtnRead(sender: UIButton){
        filePath = documentDir?.appendingPathComponent("file.txt") as! NSString
        var filecontent = fileManagaer?.contents(atPath: filePath as! String)
        do{var str = try NSString(contentsOfFile: filePath as! String, encoding: String.Encoding.utf8.rawValue)
            print(str)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func btncontentsOfDirectoryClicked(sender: AnyObject)
    {
       
        do{var arrdir = try fileManagaer?.contentsOfDirectory(atPath: documentDir as! String)
            print(arrdir!)
            print(documentDir)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func btnEqualityCheck(sender: UIButton){
        var filepath1 = documentDir?.appendingPathComponent("file1.txt")
       // fileManagaer?.createFile(atPath: filepath1!, contents: nil, attributes: nil)
        var  filepath2 = documentDir?.appendingPathComponent("file.txt")
        fileManagaer?.createFile(atPath: filepath2!, contents: nil, attributes: nil)
        print(documentDir)
        
        if fileManagaer?.contentsEqual(atPath: filepath1!, andPath: filepath2!) == true {
            print("File Is Equal")
        }else{
            print("File Is not Equal")
        }
    }
    
    @IBAction func FilePermissionChecked(sender: UIButton){
        filePath = documentDir?.appendingPathComponent("file1.txt") as! NSString
        var filepermission : NSString = ""
        
        if (fileManagaer?.isReadableFile(atPath: filePath as! String))! != nil {
            filepermission = filepermission.appending("File Is Readable") as NSString
        }
        
        if (fileManagaer?.isWritableFile(atPath: filePath as! String))! != nil {
            filepermission = filepermission.appending("file is Writable") as NSString
        }
        
        if (fileManagaer?.isExecutableFile(atPath: filePath as! String))! != nil {
            filepermission = filepermission.appending("File Is exeCutable") as NSString
        }
        print(filepermission)
    }
    
    @IBAction func btnFileExistsOrNot(sender: UIButton){
        filePath = documentDir?.appendingPathComponent("file.txt") as! NSString
        print(filePath)

        if (fileManagaer?.fileExists(atPath: filePath! as String))! == true{
            print("file Is Exist")
        }else{
            print("file is Not Exist")
        }
    }
    
    @IBAction func btnGetImage(sender: UIButton){
        
        let imageurl = URL(fileURLWithPath: documentDir as! String).appendingPathComponent("7.jpeg") as NSURL
        
        if (fileManagaer?.fileExists(atPath: imageurl.path!))! {
            let image = UIImage(contentsOfFile: imageurl.path!)
            imgview.image = image
        }else{
            print("image is not exist on path")
        }
    }
    
    @IBAction func btnSaveImagetoPath(sender: UIButton){
        
        let imageurl:NSURL = URL(fileURLWithPath: documentDir as! String).appendingPathComponent("7.jpeg") as NSURL
        let myimage = UIImage(named: "7")
        do{try UIImagePNGRepresentation(myimage!)?.write(to: imageurl as URL)
            print(imageurl)
        }catch{
            print(error.localizedDescription)
        }
       
        
        
    }
}
