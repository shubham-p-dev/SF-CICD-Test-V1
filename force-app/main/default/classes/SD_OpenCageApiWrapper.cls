public with sharing class SD_OpenCageApiWrapper {

    //Reverse Geocoding
        public results[] results;
        public String thanks;

        public class results {
            public components components;
            public String formatted;
            public geometry geometry;
        }

        public class components {
            public String category;
            public String normalized_city;
            public String type;
            public String borough;
            public String city;
            public String continent;
            public String country;
            public String country_code;
            public String coworking_space;
            public String house_number;
            public String neighbourhood;
            public String political_union;
            public String postcode;
            public String road;
            public String state;
            public String state_code;
            public String suburb;
        }

    
    //Forward Geocoding
	public class geometry {
		public Double lat;
		public Double lng;
	}
        
}