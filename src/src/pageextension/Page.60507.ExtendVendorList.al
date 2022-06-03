pageextension 60507 ExtendVendorList extends "Vendor List"
{
    layout
    {
        addafter(County)
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
        addafter("Payment Journal")
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
                    recVendor: Record Vendor;
                begin
                    CurrPage.SetSelectionFilter(recVendor);
                    if recVendor.FindSet() then
                        repeat
                            recVendor."Include For Sync" := true;
                            recVendor.Modify(false);
                        until recVendor.Next() = 0;
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
                    recVendor: Record Vendor;
                begin
                    CurrPage.SetSelectionFilter(recVendor);
                    if recVendor.FindSet() then
                        repeat
                            recVendor."Include For Sync" := false;
                            recVendor.Modify(false);
                        until recVendor.Next() = 0;
                end;
            }
        }
    }

    var
        myInt: Integer;
}