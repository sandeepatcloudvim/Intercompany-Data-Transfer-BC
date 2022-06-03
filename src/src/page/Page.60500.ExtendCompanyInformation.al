pageextension 60500 ExtendCompanyInformation extends "Company Information"  //Page id 1
{
    layout
    {
        addafter("Phone No.")
        {
            field("Master Company"; Rec."Master Company")
            {
                Caption = 'Master Company';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Inventory Setup")
        {
            action("Transfer Master Data")
            {
                ApplicationArea = All;
                Caption = 'Transfer Master Data';
                Image = Intercompany;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit "Transfer Company";
            }
        }
    }

    var
        myInt: Integer;



}