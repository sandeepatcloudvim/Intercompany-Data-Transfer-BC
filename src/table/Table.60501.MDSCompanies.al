table 60501 "MDS Companies"
{
    Caption = 'MDS Companies';

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = ,Item,Vendor,Customer,"G/L Account";
            OptionCaption = ' ,Item,Vendor,Customer,G/L Account';
        }
        field(2; "Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Company Name';
        }
        field(3; "Include for Data Sync"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Include for Data Sync';
        }
        field(4; "Overwrite Existing Data"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Overwrite Existing Data';
        }

    }

    keys
    {
        key(Key1; Type, "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        recCompanies: Record Company;
        recMDSCompanies: Record "MDS Companies";

    procedure UpdateCompmanyList(TypeValue: Option)
    var
    begin
        recCompanies.Reset();
        if recCompanies.FindSet() then
            repeat
                recMDSCompanies.Init();

                if TypeValue = 1 then
                    recMDSCompanies.Type := recMDSCompanies.Type::Item
                else
                    if TypeValue = 2 then
                        recMDSCompanies.Type := recMDSCompanies.Type::Vendor
                    else
                        if TypeValue = 3 then
                            recMDSCompanies.Type := recMDSCompanies.Type::Customer
                        else
                            if TypeValue = 4 then
                                recMDSCompanies.Type := recMDSCompanies.Type::"G/L Account";

                recMDSCompanies."Company Name" := recCompanies.Name;
                if recMDSCompanies.Insert() then;
            until recCompanies.Next() = 0;
    end;

}
