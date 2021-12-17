pageextension 60508 ExtendCustomerList extends "Customer List"
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
                    recCustomer: Record Customer;
                begin
                    CurrPage.SetSelectionFilter(recCustomer);
                    if recCustomer.FindSet() then
                        repeat
                            recCustomer."Include For Sync" := true;
                            recCustomer.Modify(false);
                        until recCustomer.Next() = 0;
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
                    recCustomer: Record Customer;
                begin
                    CurrPage.SetSelectionFilter(recCustomer);
                    if recCustomer.FindSet() then
                        repeat
                            recCustomer."Include For Sync" := false;
                            recCustomer.Modify(false);
                        until recCustomer.Next() = 0;
                end;
            }
        }
    }

    var
        myInt: Integer;
}