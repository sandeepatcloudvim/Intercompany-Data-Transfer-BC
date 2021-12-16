pageextension 60509 ExtendGLAccList extends "G/L Account List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Detail Trial Balance")
        {
            action("Data Sync Company")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Data Sync Company';
                Image = Translations;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "MDS Companies";
                RunPageLink = Type = const("G/L Account");

            }
        }
    }

    var
        myInt: Integer;
}