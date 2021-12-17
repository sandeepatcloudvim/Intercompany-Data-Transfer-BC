codeunit 60501 "Intercompany Event Subscriber"
{

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', false, false)]
    local procedure T27_UpdateValue(var Rec: Record Item)
    begin
        Rec."Include For Sync" := true;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure T23_UpdateValue(var Rec: Record Vendor)
    begin
        Rec."Include For Sync" := true;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', false, false)]
    local procedure T18_UpdateValue(var Rec: Record Customer)
    begin
        Rec."Include For Sync" := true;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterInsertEvent', '', false, false)]
    local procedure T15_UpdateValue(var Rec: Record "G/L Account")
    begin
        Rec."Include For Sync" := true;
        Rec.Modify();
    end;
}