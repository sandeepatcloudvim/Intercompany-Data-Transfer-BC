pageextension 60503 ExtendVendorCard extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(PayVendor)
        {
            action("Data Sync Company")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Data Sync Company';
                Image = Translations;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "MDS Companies";
                RunPageLink = Type = const(Vendor);

            }
        }
    }

    var
        myInt: Integer;
}