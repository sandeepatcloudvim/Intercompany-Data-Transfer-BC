tableextension 60504 ExtendGLAccount extends "G/L Account"
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