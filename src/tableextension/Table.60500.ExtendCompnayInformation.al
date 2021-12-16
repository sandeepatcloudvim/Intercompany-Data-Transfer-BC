tableextension 60500 ExtendCompanyInformation extends "Company Information"
{
    fields
    {
        field(50000; "Master Company"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Master Company';
            trigger OnValidate()
            begin
                ValidateMasterCompany();
            end;
        }
    }

    var
        myInt: Integer;
        FromCompanies: Record Company;
        ToCompanies: Record Company;
        CompanyInfo: Record "Company Information";

    local procedure ValidateMasterCompany()
    begin
        FromCompanies.SetRange(Name, Rec.Name);
        if FromCompanies.FindFirst then
            repeat
                ToCompanies.Reset;
                ToCompanies.SetFilter(Name, '<>%1', FromCompanies.Name);
                if ToCompanies.FindSet then
                    repeat
                        CompanyInfo.ChangeCompany(ToCompanies.Name);
                        CompanyInfo.SetFilter("Master Company", '%1', true);
                        if CompanyInfo.FindFirst then
                            Error('Master Company already existing in %1 company', CompanyInfo.Name);
                    until ToCompanies.Next = 0;
            until FromCompanies.Next = 0;
    end;
}