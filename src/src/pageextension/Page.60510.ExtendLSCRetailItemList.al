pageextension 60510 ExtendLSCRetailItemList extends "LSC Retail Item List"
{
    layout
    {
        addafter("Vendor Item No.")
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
                    recItem: Record Item;
                begin
                    CurrPage.SetSelectionFilter(recItem);
                    if recItem.FindSet() then
                        repeat
                            recItem."Include For Sync" := true;
                            recItem.Modify(false);
                        until recItem.Next() = 0;
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
                    recItem: Record Item;
                begin
                    CurrPage.SetSelectionFilter(recItem);
                    if recItem.FindSet() then
                        repeat
                            recItem."Include For Sync" := false;
                            recItem.Modify(false);
                        until recItem.Next() = 0;
                end;
            }
        }

    }

    var
        myInt: Integer;
}