tableextension 60503 ExtendCustomer extends Customer
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