
import  GoogleMaps

protocol LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    

    
    //var locationManager: CLLocationManager?
    var index : Int = 0
    var lastLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    private weak var _locationListenerDelegate : GPSLocationSensorListenerDelegate!
    private static var _arLocation : ARLocation?
    //private let arLocatiotag = ARLocationTagScene(name: "AR_TAG_SCENE")
    private var locationServiceInstance : LocationService?
    private let locationManager = CLLocationManager()
    
    public func setLocationSensorListenerDelegate(locationListenerDelegate : GPSLocationSensorListenerDelegate!){
        self._locationListenerDelegate = locationListenerDelegate
    }
    
    public func removeLocationSensorListenerDelegate(){
        self._locationListenerDelegate = nil
    }
    
    
    public func getLocationServiceInstance() -> LocationService{
            locationServiceInstance = LocationService()
            self.locationServiceInstance?.startUpdatingLocation()
        return locationServiceInstance!
    }
    
//    private override init() {
//        
//    }
    
//    override init() {
//        super.init()
//
//        self.locationManager = CLLocationManager()
//        guard let locationManager = self.locationManager else {
//            return
//        }
//
//        if CLLocationManager.authorizationStatus() == .notDetermined {
//            // you have 2 choice
//            // 1. requestAlwaysAuthorization
//            // 2. requestWhenInUseAuthorization
//            locationManager.requestAlwaysAuthorization()
//        }
//
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//    }
    
    func startUpdatingLocation() {
        
        self.locationManager.requestAlwaysAuthorization() //Request permission to use the location when app is running
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
                locationManager.delegate = self
                //locationManager.distanceFilter = kCLDistanceFilterNone
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            //            locationManager.allowDeferredLocationUpdates(untilTraveled: MIN_DISTANCE_CHANGE, timeout: TIME_INTERVAL)
            
                locationManager.startUpdatingLocation()
            
        }
        else{
            //throw LocationError.LocationServiceNotAvailableException("No Location Service available")
        }
    }
    
    func stopUpdatingLocation() {
        //print("Stop Location Updates")
        self.locationManager.stopUpdatingLocation()
    }
    
    
    
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.pausesLocationUpdatesAutomatically = false
        let loc = CLLocation(latitude: 32.77845, longitude: -96.75830)
        LocationService._arLocation = ARLocation(CurrentLocation: loc, Timestamp: Double(Date().ticks))
        
        if self._locationListenerDelegate != nil{
            _locationListenerDelegate.GPSLocationAvailable(location: LocationService._arLocation!)
        }
    }
    
    public static func getLocation() throws -> ARLocation
    {
        //print("arlocation: \(_arLocation)")
        if !CLLocationManager.locationServicesEnabled(){
            //throw LocationError.LocationServiceNotAvailableException("No Location Service available")
        }
        
        if _arLocation == nil {
            throw LocationError.LocationNotAvailableException("Location is not available yet.")
        }
        
//        if _isLocationAuthorizedDenied{
//            throw LocationError.LocationPermissionNotAvailableException("User selected Not authorized.")
//        }
        
        return _arLocation!
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation){
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error: error)
    }
}
