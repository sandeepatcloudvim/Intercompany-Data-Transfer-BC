pageextension 60510 ExtendLSCRetailItemList extends "LSC Retail Item List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Item Journal")
        {
            action("Data Sync Company")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Data Sync Company';
                Image = Translations;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "MDS Companies";
                RunPageLink = Type = const(Item);
            }
        }
    }

    var
        myInt: Integer;
}