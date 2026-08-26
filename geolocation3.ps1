Add-Type -TypeDefinition @"
using System;
using Windows.Devices.Geolocation;

public class LocationHelper
{
    public static string GetLocation()
    {
        try
        {
            var locator = new Geolocator();

            locator.DesiredAccuracy = PositionAccuracy.High;

            var operation = locator.GetGeopositionAsync();

            operation.AsTask().Wait();

            var position = operation.GetResults();

            if (position == null)
                return "NO_LOCATION";

            var coordinate = position.Coordinate;

            return String.Format(
                "Latitude={0};Longitude={1};Accuracy={2};Timestamp={3};Source={4}",
                coordinate.Point.Position.Latitude,
                coordinate.Point.Position.Longitude,
                coordinate.Accuracy,
                coordinate.Timestamp,
                coordinate.PositionSource
            );
        }
        catch (Exception ex)
        {
            return "ERROR=" + ex.Message;
        }
    }
}
"@

$result = [LocationHelper]::GetLocation()

Write-Host $result
