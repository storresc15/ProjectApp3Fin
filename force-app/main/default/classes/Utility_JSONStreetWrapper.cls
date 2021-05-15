public class Utility_JSONStreetWrapper {
    
    // here rows is the name of field in json this variable should be
public class Components {
    public String primary_number;
    public String street_predirection;
    public String street_name;
    public String street_suffix;
    public String city_name;
    public String default_city_name;
    public String state_abbreviation;
    public String zipcode;
    public String plus4_code;
    public String delivery_point;
    public String delivery_point_check_digit;
}

public Integer input_index;
public Integer candidate_index;
public String delivery_line_1;
public String last_line;
public String delivery_point_barcode;
public Components components;
public Metadata metadata;
public Analysis analysis;

public class Analysis {
    public String dpv_match_code;
    public String dpv_footnotes;
    public String dpv_cmra;
    public String dpv_vacant;
    public String active;
}

public class Metadata {
    public String record_type;
    public String zip_type;
    public String county_fips;
    public String county_name;
    public String carrier_route;
    public String congressional_district;
    public String rdi;
    public String elot_sequence;
    public String elot_sort;
    public Double latitude;
    public Double longitude;
    public String precision;
    public String time_zone;
    public Integer utc_offset;
    public Boolean dst;
}

}