pageextension 60505 ExtendGLAccCard extends "G/L Account Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("G/L Register")
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