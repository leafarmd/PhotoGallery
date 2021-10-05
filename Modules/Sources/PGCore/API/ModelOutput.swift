import Foundation

// MARK: - SizesOutput
public struct SizesOutput: Decodable {
    public init(
        sizes: Sizes,
        stat: String
    ) {
        self.sizes = sizes
        self.stat = stat
    }
    
   public let sizes: Sizes
   public let stat: String
}

// MARK: - Sizes
public struct Sizes: Decodable {
    public init(
        canblog: Int,
        canprint: Int,
        candownload: Int
        , size: [Size]
    ) {
        self.canblog = canblog
        self.canprint = canprint
        self.candownload = candownload
        self.size = size
    }
    
   public let canblog: Int
   public let canprint: Int
   public let candownload: Int
   public let size: [Size]
}

// MARK: - Size
public struct Size: Decodable {
    public init(
        label: String,
        width: Int,
        height: Int,
        source: String,
        url: String,
        media: String
    ) {
        self.label = label
        self.width = width
        self.height = height
        self.source = source
        self.url = url
        self.media = media
    }
    
   public let label: String
   public let width: Int
   public let height: Int
   public let source: String
   public let url: String
   public let media: String
}

// MARK: - PhotosOutput
public struct PhotosOutput: Decodable {
    public init(photos: Photos) {
        self.photos = photos
    }
    
    public let photos: Photos
}

// MARK: - Photos
public struct Photos: Decodable {
    public init(
        page: Int,
        pages: Int,
        perpage: Int,
        total: Int,
        photo: [Photo]
    ) {
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.total = total
        self.photo = photo
    }
    
    public let page: Int
    public let pages: Int
    public let perpage: Int
    public let total: Int
    public let photo: [Photo]
}

// MARK: - Photo
public struct Photo: Decodable {
    public init(
        id: String,
        owner: String,
        secret: String,
        server: String,
        farm: Int,
        title: String,
        ispublic: Int,
        isfriend: Int,
        isfamily: Int
    ) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
    }
    
    public let id: String
    public let owner: String
    public let secret: String
    public let server: String
    public let farm: Int
    public let title: String
    public let ispublic: Int
    public let isfriend: Int
    public let isfamily: Int
}
