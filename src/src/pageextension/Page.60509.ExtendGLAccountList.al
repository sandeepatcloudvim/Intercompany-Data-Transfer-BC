pageextension 60509 ExtendGLAccList extends "G/L Account List"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("Include For Sync"; Rec."Include For Sync")
            {
                ApplicationArea = All;
                Caption = 'Sync Data';
            }
        }
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
        addafter("Data Sync Company")
        {
            action("Select Data Sync")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Select for Data Sync';
                Image = Translations;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    recGLAcc: Record "G/L Account";
                begin
                    CurrPage.SetSelectionFilter(recGLAcc);
                    if recGLAcc.FindSet() then
                        repeat
                            recGLAcc."Include For Sync" := true;
                            recGLAcc.Modify(false);
                        until recGLAcc.Next() = 0;
                end;

            }
            action("Clear Data Sync")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Clear Data Sync';
                Image = Translations;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    recGLAcc: Record "G/L Account";
                begin
                    CurrPage.SetSelectionFilter(recGLAcc);
                    if recGLAcc.FindSet() then
                        repeat
                            recGLAcc."Include For Sync" := false;
                            recGLAcc.Modify(false);
                        until recGLAcc.Next() = 0;
                end;
            }
        }
    }

    var
        myInt: Integer;
}