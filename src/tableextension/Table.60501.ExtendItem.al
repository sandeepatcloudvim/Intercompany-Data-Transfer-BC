tableextension 60501 ExtendItem extends Item
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