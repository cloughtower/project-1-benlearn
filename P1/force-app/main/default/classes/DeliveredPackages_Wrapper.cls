public inherited sharing class DeliveredPackages_Wrapper {
    
    public String name {get; set;}
    public String address {get; set;} 
    public Decimal weight {get; set;}
    public Decimal height {get; set;}
    public Decimal width {get; set;}
    public Decimal insurance {get; set;}
    public String status {get; set;}

    public DeliveredPackages_Wrapper(String name, String address, Decimal weight, 
                                       Decimal height, Decimal width, Decimal insurance,
                                       String status) {
        this.name = name;
        this.address = address;
        this.weight = weight;
        this.height = height;
        this.width = width;
        this.insurance = insurance;
        this.status = status;
    }
}