using System;
 
namespace HaversineFormula
{
    public enum DistanceType { Miles, Kilometers };
    class Haversine
    {
        public double Distance(double lat1, double long1, double lat2, double long2, DistanceType type)
        {
            double R = (type == DistanceType.Miles) ? 3960 : 6371;
 
            double dLat = this.toRadian(lat2 - lat1);
            double dLon = this.toRadian(long2 - long1);
 
            double a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
                Math.Cos(this.toRadian(lat1)) *Math.Cos(this.toRadian(lat2)) *
                Math.Sin(dLon / 2) * Math.Sin(dLon / 2);
            double c = 2 * Math.Asin(Math.Min(1, Math.Sqrt(a)));
            double d = R * c;
 
            return d;
        }

        private double toRadian(double val)
        {
            return (Math.PI / 180) * val;
        }
    }
}