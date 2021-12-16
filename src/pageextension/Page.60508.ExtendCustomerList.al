pageextension 60508 ExtendCustomerList extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Blanket Orders")
        {
            action("Data Sync Company")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Data Sync Company';
                Image = Translations;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "MDS Companies";
                RunPageLink = Type = const(Customer);

            }
        }
    }

    var
        myInt: Integer;
}