//
//  TSYoutubeParser.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 4/18/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
import UIKit

//MARK: YouTubeThumbnailQuality Enum
enum YouTubeThumbnail
{
    case YouTubeThumbnailDefault
    case YouTubeThumbnailDefaultMedium
    case YouTubeThumbnailDefaultHighQuality
    case YouTubeThumbnailDefaultMaxQuality
}
extension URL
{
    func dictionaryForQueryString()-> [String:AnyObject]
    {
        let queryStr = self.query
        return queryStr!.dictionaryFromQueryStringComponents()
    }
}
extension String
{
    /**
     Convenient method for decoding a html encoded string
     */
    func stringByDecodingURLFormat()-> String
    {
        var result = self.replacingOccurrences(of: "+", with: " ")
        result = result.removingPercentEncoding!
        return result
    }
    /**
     Parses a query string
     @return key value dictionary with each parameter as an array
     */
    func dictionaryFromQueryStringComponents()-> [String:AnyObject]
    {
        var parameters = [String:AnyObject]()
        
        for keyValue in self.components(separatedBy: "&")
        {
            let keyValueArray = keyValue.components(separatedBy:"=")
            if keyValueArray.count < 2
            {
                continue
            }
            let key = (keyValueArray[0]).stringByDecodingURLFormat()
            let value = keyValueArray[0].stringByDecodingURLFormat()
            
            var results = parameters[key]
            
            if results != nil
            {
                results = [AnyObject]() as AnyObject
                parameters[key] = results
            }
            results?.add(value)
        }
        return parameters
    }
}


let kYoutubeInfoURL = "https://www.youtube.com/get_video_info?video_id="
let kYoutubeThumbnailURL = "https://img.youtube.com/vi/%@/%@.jpg"
let kYoutubeDataURL = "https://gdata.youtube.com/feeds/api/videos/%@?alt=json"
let kUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4"


class TSYoutubeParser: NSObject
{
    /**
     Method for retrieving the youtube ID from a youtube URL
     
     @param youtubeURL the the complete youtube video url, either youtu.be or youtube.com
     @return string with desired youtube id
     */
    
    func youtubeIDFromYoutubeURL(youtubeURL:URL)->String
    {
        var youtubeID = ""
        if youtubeURL.host == "youtu.be"
        {
            youtubeID = youtubeURL.pathComponents.first!
        }
        else if youtubeURL.absoluteString.range(of: "www.youtube.com/embed") != nil
        {
            youtubeID = youtubeURL.pathComponents[2]
        }
       else  if (youtubeURL.host == "youtube.googleapis.com") || (youtubeURL.host == "www.youtube.com")
        {
            youtubeID = youtubeURL.pathComponents[2]
        }
       else
        {
            youtubeID = (youtubeURL.dictionaryForQueryString()["v"] as! Array).first!
        }
        return youtubeID
    }
    
    /**
     Method for retreiving a iOS supported video link
     @param youtubeURL the the complete youtube video url
     @return dictionary with the available formats for the selected video
     */
    func h264videosWithYoutubeURL(youtubeURL:URL)->[String:AnyObject]
    {
        let youtubeID = self.youtubeIDFromYoutubeURL(youtubeURL: youtubeURL)
        return self.h264videosWithYoutubeID(youtubeID: youtubeID)
    }
    /**
     Method for retreiving an iOS supported video link
     
     @param youtubeID the id of the youtube video
     @return dictionary with the available formats for the selected video
    */
    func h264videosWithYoutubeID(youtubeID:String)->[String:AnyObject]
    {
//        if youtubeID != String()
//        {
//            let url = URL.init(string: kYoutubeInfoURL + youtubeID)
//            var urlRequest = URLRequest.init(url: url!)
//            urlRequest.addValue(kUserAgent, forHTTPHeaderField: "User-Agent")
//            urlRequest.httpMethod = "GET"
//
//            var data: [AnyHashable: Any]? = nil
//            // Lock threads with semaphore
//            var semaphore = DispatchSemaphore(value: 0)
//
//            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (_ responseData: Data?, _ response: URLResponse?, _ error: Error?) in
//                    if error != nil
//                    {
//                        let responseString:String = String.init(data: responseData!, encoding: String.Encoding.utf8)!
//                        let parts :[String:AnyObject] = responseString.dictionaryFromQueryStringComponents()
//
//                        if parts = [String:AnyObject]()
//                        {
//                            let strAr :[AnyObject] = parts["url_encoded_fmt_stream_map"]! as! [AnyObject]
//                            let fmtStreamMapString:String = strAr[0] as! String
//
//                            if (fmtStreamMapString.count) > 0
//                            {
//                                let fmtStreamMapArray = fmtStreamMapString.components(separatedBy: ",")
//                                var videoDictionary = [AnyHashable: Any]()
//                                for videoEncodedString: String? in fmtStreamMapArray
//                                {
//                                    var videoComponents = videoEncodedString?.dictionaryFromQueryStringComponents()
//                                    let strtype :[AnyObject] = parts["type"]! as! [AnyObject]
//                                    let type:String = (strtype[0] as! String).stringByDecodingURLFormat()
//                                    var signature: String? = nil
//                                    if videoComponents?["stereo3d"] == nil
//                                    {
//                                        if videoComponents?["itag"] != nil
//                                        {
//                                            let stritag :[AnyObject] = videoComponents!["itag"]! as! [AnyObject]
//                                            let itag:String = (stritag[0] as! String)
//                                            signature = itag
//                                        }
//                                        if signature != nil && Int((type as NSString?)?.range(of: "mp4").length ?? 0) > 0
//                                        {
//                                            let strurl :[AnyObject] = videoComponents!["url"]! as! [AnyObject]
//                                            let vcurl:String = (strurl[0] as! String)
//                                            var url = vcurl.stringByDecodingURLFormat()
//                                            url = "\(url)&signature=\(signature ?? "")"
//
//                                            let strquality :[AnyObject] = videoComponents!["quality"]! as! [AnyObject]
//                                            let vcquality:String = (strquality[0] as! String)
//
//                                            var quality = vcquality.stringByDecodingURLFormat()
//                                            if videoComponents?["stereo3d"] != nil && (Int(truncating: (videoComponents?["stereo3d"])! as! NSNumber) != 0) {
//                                                quality = quality + String("-stereo3d")
//                                            }
//                                            if videoDictionary[quality] == nil {
//                                                videoDictionary[quality] = url
//                                            }
//                                        }
//                                    }
//                                }
//                                // add some extra information about this video to the dictionary we pass back to save on the amounts of network requests
//                                if videoDictionary.count > 0 {
//                                    var optionsDict = [AnyHashable: Any]()
//                                    let keys = [                                //@"author", // youtube channel name
//                                        //@"avg_rating", // average ratings on yt when downloaded
//                                        "iurl",                                 //@"iurlmaxres", @"iurlsd", // thumbnail urls
//                                        //@"keywords", // author defined keywords
//                                        "length_seconds",                                 // total duration in seconds
//                                        "title"]
//                                    for key in keys
//                                    {
//                                        optionsDict[key] = parts[key]?[0]  // [0] because we want the object and not the array
//                                    }
//                                    videoDictionary["moreInfo"] =  optionsDict
//                                }
//                                data = videoDictionary
//                            }
//                            else if (parts["live_playback"] != nil) && (parts["hlsvp"] != nil) && ((parts["hlsvp"]? as! Array).count > 0)
//                            {
//                                data = ["live":(parts["hlsvp"]? as! Array).first]
//                            }
//                        }
//                    }
//            semaphore.signal()
//                })
//            semaphore.wait()
//            return data
//        }
        return [String:AnyObject]()
    }
    /**
     Block based method for retreiving a iOS supported video link
     
     @param youtubeURL the the complete youtube video url
     @param completeBlock the block which is called on completion
     */
    func h264videosWithYoutubeURL(youtubeURL:URL,completeBlock:@escaping (_ videoDictionary:[String:AnyObject],_ error:Error)->Void)
    {
         let youtubeID = self.youtubeIDFromYoutubeURL(youtubeURL: youtubeURL)
        if  youtubeID != String()
        {
           DispatchQueue.global().async
            {
                let dict = self.h264videosWithYoutubeID(youtubeID: youtubeID)
                
                DispatchQueue.main.async {
                    completeBlock(dict, "" as! Error)
                }
            }
        }
        else
        {
            completeBlock([String:AnyObject](), NSError.init(domain: "me.hiddencode.yt-parser", code: 1001, userInfo: [NSLocalizedDescriptionKey:"Invalid YouTube URL"]))
        }
    }
    
    /**
     Method for retreiving a thumbnail url for wanted youtube id
     @param youtubeURL the complete youtube video id
     @param thumbnailSize the wanted size of the thumbnail
     */
    
    func thumbnailUrlForYoutubeURL(youtubeURL:URL,thumbnailSize:YouTubeThumbnail) -> URL
    {
        var thumbnailSizeString :String = ""
        var url : URL?
        if  youtubeURL != nil
        {
            switch thumbnailSize {
            case .YouTubeThumbnailDefault:
                thumbnailSizeString = "default"
                break
            case .YouTubeThumbnailDefaultMedium:
                thumbnailSizeString = "mqdefault";
                break;
            case .YouTubeThumbnailDefaultHighQuality:
                thumbnailSizeString = "hqdefault";
                break;
            case .YouTubeThumbnailDefaultMaxQuality:
                thumbnailSizeString = "maxresdefault";
                break;
            default:
                thumbnailSizeString = "default";
                break;
            }
        }
        
        let youtubeID = self.youtubeIDFromYoutubeURL(youtubeURL: youtubeURL)
        url = URL.init(string: kYoutubeThumbnailURL + youtubeID + thumbnailSizeString )
        return url!
    }
    
    /**
     Method for retreiving a thumbnail for wanted youtube url
     @param youtubeURL the the complete youtube video url
     @param thumbnailSize the wanted size of the thumbnail
     @param completeBlock the block which is called on completion
     */
    
    func thumbnailUrlForYoutubeURL(youtubeURL:URL,thumbnailSize:YouTubeThumbnail,completeBlock:@escaping (_ image:UIImage,_ error:Error)->Void)
    {
        
    }
    
    /**
     Method for retreiving a thumbnail for wanted youtube id
     @param youtubeURL the complete youtube video id
     @param thumbnailSize the wanted size of the thumbnail
     @param completeBlock the block which is called on completion
     */
    func thumbnailForYoutubeID(youtubeID:String,thumbnailSize:YouTubeThumbnail,completeBlock:@escaping (_ image:UIImage,_ error:Error)->Void)
    {
        
    }
    /**
     Method for retreiving all the details of a youtube video
     @param youtubeURL the the complete youtube video url
     @param completeBlock the block which is called on completion
     */
    func detailsForYouTubeURL(youtubeURL:URL,completeBlock:@escaping (_ videoDictionary:[String:AnyObject],_ error:Error)->Void)
    {
        
    }
}
