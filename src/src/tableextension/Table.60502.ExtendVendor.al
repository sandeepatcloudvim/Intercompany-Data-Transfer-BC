tableextension 60502 ExtendVendor extends Vendor
{
    fields
    {
        field(60500; "Include For Sync"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Include For Sync';
        }

    }

    var
        myInt: Integer;
}