import UIKit

extension UIImageView
{
    
    func loadImageWith(url: URL) -> URLSessionDownloadTask
    {
        let session = URLSession.shared
        var selfImage: UIImage?
        
        let downloadTask = session.downloadTask(with: url, completionHandler:
            {
                
                [weak self] url, response, error in
                
                if error == nil, let url = url
                {
                    do {
                        let data = try Data(contentsOf: url)
                        selfImage = UIImage(data: data) ?? nil
                    }
                    catch {
                        print("no data")
                    }
                    
                    DispatchQueue.main.async {
                        if let strongSelf = self
                        {
                            if selfImage != nil {
                            strongSelf.image = selfImage
                            }
                            
                        }
                    }
                    
                    
                
        }
            })
        
        downloadTask.resume()
        return downloadTask
        
    }
}
