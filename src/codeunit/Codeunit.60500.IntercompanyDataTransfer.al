codeunit 60500 "Transfer Company"
{

    trigger OnRun()
    begin
        CompanyInfo.Get;
        if not CompanyInfo."Master Company" then
            exit;

        Companies.SetRange(Name, CompanyInfo.Name);
        // Set the filter from company
        if Companies.FindFirst then
            repeat  // if record find in the from company

                // Customer Transfer
                FromCustomerlist.ChangeCompany(Companies.Name);  // then point to the from company list of customer
                FromCustomerlist.SetFilter("Include For Sync", '%1', true);
                if FromCustomerlist.FindSet() then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Customer);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToCustomer.Reset();
                                ToCustomer.ChangeCompany(ToCompanies."Company Name");
                                ToCustomer.SetRange("No.", FromCustomerlist."No."); //check on the No
                                if not ToCustomer.FindFirst then begin
                                    ToCustomer.TransferFields(FromCustomerlist);
                                    if ToCustomer.Insert then;
                                end;
                            until ToCompanies.Next = 0;
                        FromCustomerlist."Include For Sync" := false;
                        FromCustomerlist.Modify(false);
                    until FromCustomerlist.Next = 0;

                // Default Dimension - Customer
                FromDefaultDim.ChangeCompany(Companies.Name);  // then point to the from company list of Dimensions
                if FromDefaultDim.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Customer);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToDefaultDim.Reset();
                                ToDefaultDim.ChangeCompany(ToCompanies."Company Name");
                                ToDefaultDim.SetRange("Table ID", Database::Customer);
                                ToDefaultDim.SetRange("No.", FromDefaultDim."No.");
                                ToDefaultDim.SetRange("Dimension Code", FromDefaultDim."Dimension Code");
                                if not ToDefaultDim.FindFirst() then begin
                                    ToDefaultDim.TransferFields(FromDefaultDim);
                                    if ToDefaultDim.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromDefaultDim.Next = 0;

                //Vendor Transfer
                FromVendorlist.ChangeCompany(Companies.Name);  // then point to the from company list of Vendor
                FromVendorlist.SetFilter("Include For Sync", '%1', true);
                if FromVendorlist.FindSet() then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Vendor);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToVendor.ChangeCompany(ToCompanies."Company Name");
                                ToVendor.SetRange("No.", FromVendorlist."No."); //check on the No
                                if not ToVendor.FindFirst then begin
                                    ToVendor.TransferFields(FromVendorlist);
                                    if ToVendor.Insert then;
                                end;
                            until ToCompanies.Next = 0;
                        FromVendorlist."Include For Sync" := false;
                        FromVendorlist.Modify(false);
                    until FromVendorlist.Next = 0;


                // Vendor Bank Details
                FromVenBackAcc.Reset();
                FromVenBackAcc.ChangeCompany(Companies.Name);// then point to the from company list of Vendor bank details
                if FromVenBackAcc.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Vendor);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToVenBackAcc.Reset();
                                ToVenBackAcc.ChangeCompany(ToCompanies."Company Name");
                                ToVenBackAcc.SetRange("Vendor No.", FromVenBackAcc."Vendor No.");
                                ToVenBackAcc.SetRange(Code, FromVenBackAcc.Code);
                                if not ToVenBackAcc.FindFirst() then begin
                                    ToVenBackAcc.TransferFields(FromVenBackAcc);
                                    if ToVenBackAcc.Insert(true) then;
                                end;

                            until ToCompanies.Next = 0;
                    until FromVenBackAcc.Next = 0;


                // Default Dimension - Vendor
                FromDefaultDim.ChangeCompany(Companies.Name);  // then point to the from company list of Vendor Dimensions
                if FromDefaultDim.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Vendor);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToDefaultDim.Reset();
                                ToDefaultDim.ChangeCompany(ToCompanies."Company Name");
                                ToDefaultDim.SetRange("Table ID", Database::Vendor);
                                ToDefaultDim.SetRange("No.", FromDefaultDim."No.");
                                ToDefaultDim.SetRange("Dimension Code", FromDefaultDim."Dimension Code");
                                if not ToDefaultDim.FindFirst() then begin
                                    ToDefaultDim.TransferFields(FromDefaultDim);
                                    if ToDefaultDim.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromDefaultDim.Next = 0;


                // Item Transfer
                FromItemlist.ChangeCompany(Companies.Name);  // then point to the from company list of Item
                FromItemlist.SetFilter("Include For Sync", '%1', true);
                if FromItemlist.FindSet() then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToItem.ChangeCompany(ToCompanies."Company Name");
                                ToItem.SetRange("No.", FromItemlist."No."); //check on the No
                                if not ToItem.FindFirst then begin
                                    ToItem.TransferFields(FromItemlist);
                                    if ToItem.Insert then;
                                end;
                            until ToCompanies.Next = 0;
                        FromItemlist."Include For Sync" := false;
                        FromItemlist.Modify(false);
                    until FromItemlist.Next = 0;


                // Default Dimension - Item
                FromDefaultDim.ChangeCompany(Companies.Name);  // then point to the from company list of Item Dimension
                if FromDefaultDim.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToDefaultDim.Reset();
                                ToDefaultDim.ChangeCompany(ToCompanies."Company Name");
                                ToDefaultDim.SetRange("Table ID", Database::Item);
                                ToDefaultDim.SetRange("No.", FromDefaultDim."No.");
                                ToDefaultDim.SetRange("Dimension Code", FromDefaultDim."Dimension Code");
                                if not ToDefaultDim.FindFirst() then begin
                                    ToDefaultDim.TransferFields(FromDefaultDim);
                                    if ToDefaultDim.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromDefaultDim.Next = 0;

                //Item Unit of Measure - Item
                FromItemUOM.ChangeCompany(Companies.Name);  // then point to the from company list of Item of Unit of Measure
                if FromItemUOM.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToItemUOM.ChangeCompany(ToCompanies."Company Name");
                                ToItemUOM.SetRange("Item No.", FromItemUOM."Item No.");
                                ToItemUOM.SetRange(Code, FromItemUOM.Code);
                                if not ToItemUOM.FindFirst then begin
                                    ToItemUOM.TransferFields(FromItemUOM);
                                    if ToItemUOM.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromItemUOM.Next = 0;

                //Sales Price - Item
                FromSalesPrice.ChangeCompany(Companies.Name);  // then point to the from company list ofSales Price
                if FromSalesPrice.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToSalesPrice.ChangeCompany(ToCompanies."Company Name");
                                ToSalesPrice.SetRange("Item No.", FromSalesPrice."Item No.");
                                ToSalesPrice.SetRange("Sales Code", FromSalesPrice."Sales Code");
                                ToSalesPrice.SetRange("Sales Type", FromSalesPrice."Sales Type");
                                ToSalesPrice.SetRange("Currency Code", FromSalesPrice."Currency Code");
                                ToSalesPrice.SetRange("Starting Date", FromSalesPrice."Starting Date");
                                if not ToSalesPrice.FindFirst then begin
                                    ToSalesPrice.TransferFields(FromSalesPrice);
                                    if ToSalesPrice.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromSalesPrice.Next = 0;

                // LSC Item Distribution - Item
                FromLSCItemDist.ChangeCompany(Companies.Name);  // then point to the from company list of LSC Item Distribution
                if FromLSCItemDist.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToLSCItemDist.Reset();
                                ToLSCItemDist.ChangeCompany(ToCompanies."Company Name");
                                ToLSCItemDist.SetRange(Code, ToLSCItemDist.Code);
                                ToLSCItemDist.SetRange("Item No.", FromLSCItemDist."Item No.");
                                if not ToLSCItemDist.FindFirst() then begin
                                    ToLSCItemDist.TransferFields(FromLSCItemDist);
                                    if ToLSCItemDist.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromLSCItemDist.Next = 0;

                // LSC Item Scale - Item
                FromLSCItemScale.ChangeCompany(Companies.Name);  // then point to the from company list of LSC Item Scale
                if FromLSCItemScale.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToLSCItemScale.Reset();
                                ToLSCItemScale.ChangeCompany(ToCompanies."Company Name");
                                ToLSCItemScale.SetRange("Item No.", FromLSCItemScale."Item No.");
                                if not ToLSCItemScale.FindFirst then begin
                                    ToLSCItemScale.TransferFields(FromLSCItemScale);
                                    if ToLSCItemScale.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromLSCItemScale.Next = 0;

                // LSC KDS Item Section Routing- Item
                FromLSCKDSItemSectionRoutingt.ChangeCompany(Companies.Name);  // then point to the from company list of LSC Item Scale
                if FromLSCKDSItemSectionRoutingt.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToLSCKDSItemSectionRoutingt.Reset();
                                ToLSCKDSItemSectionRoutingt.ChangeCompany(ToCompanies."Company Name");
                                ToLSCKDSItemSectionRoutingt.SetFilter("Item Type", '%1', FromLSCKDSItemSectionRoutingt."Item Type");
                                ToLSCKDSItemSectionRoutingt.SetRange(Code, FromLSCKDSItemSectionRoutingt.Code);
                                ToLSCKDSItemSectionRoutingt.SetRange("Line No.", FromLSCKDSItemSectionRoutingt."Line No.");
                                if not ToLSCKDSItemSectionRoutingt.FindFirst then begin
                                    ToLSCKDSItemSectionRoutingt.TransferFields(FromLSCKDSItemSectionRoutingt);
                                    if ToLSCKDSItemSectionRoutingt.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromLSCKDSItemSectionRoutingt.Next = 0;

                // LSC Scale Free Message
                FromLSCScaleFreeMsg.ChangeCompany(Companies.Name);  // then point to the from company list of LSC Scale Free Message
                if FromLSCScaleFreeMsg.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToLSCScaleFreeMsg.Reset();
                                ToLSCScaleFreeMsg.ChangeCompany(ToCompanies."Company Name");
                                ToLSCScaleFreeMsg.SetRange("Item No.", FromLSCScaleFreeMsg."Item No.");
                                if not ToLSCScaleFreeMsg.FindFirst then begin
                                    ToLSCScaleFreeMsg.TransferFields(FromLSCScaleFreeMsg);
                                    if ToLSCScaleFreeMsg.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromLSCScaleFreeMsg.Next = 0;

                // LSC Barcodes
                FromLSCBarcodes.ChangeCompany(Companies.Name);  // then point to the from company list of LSC Barcodes
                if FromLSCBarcodes.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::Item);
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToLSCBarcodes.ChangeCompany(ToCompanies."Company Name");
                                ToLSCBarcodes.SetRange("Item No.", FromLSCBarcodes."Item No.");
                                ToLSCBarcodes.SetRange("Barcode No.", FromLSCBarcodes."Barcode No.");
                                if not ToLSCBarcodes.FindFirst then begin
                                    ToLSCBarcodes.TransferFields(FromLSCBarcodes);
                                    if ToLSCBarcodes.Insert(true) then;
                                end;
                            until ToCompanies.Next = 0;
                    until FromLSCBarcodes.Next = 0;


                //G/L Account Transfer
                FromGLAcclist.ChangeCompany(Companies.Name);  // then point to the from company list of G/L Account
                FromGLAcclist.SetFilter("Include For Sync", '%1', true);
                if FromGLAcclist.FindFirst then
                    repeat
                        ToCompanies.Reset;
                        ToCompanies.SetRange(Type, ToCompanies.Type::"G/L Account");
                        ToCompanies.SetRange("Include for Data Sync", True);
                        if ToCompanies.FindSet then
                            repeat
                                ToGLAcclist.ChangeCompany(ToCompanies."Company Name");
                                ToGLAcclist.SetRange("No.", FromGLAcclist."No."); //check on the Name
                                if not ToGLAcclist.FindFirst then begin
                                    ToGLAcclist.TransferFields(FromGLAcclist);
                                    if ToGLAcclist.Insert then;
                                end;
                            until ToCompanies.Next = 0;
                        FromGLAcclist."Include For Sync" := false;
                        FromGLAcclist.Modify(false);
                    until FromGLAcclist.Next = 0;

            until Companies.Next = 0;


        // Default Dimension - G/L Account
        FromDefaultDim.ChangeCompany(Companies.Name);  // then point to the from company list of G/L Account Dimensions
        if FromDefaultDim.FindFirst then
            repeat
                ToCompanies.Reset;
                ToCompanies.SetRange(Type, ToCompanies.Type::"G/L Account");
                ToCompanies.SetRange("Include for Data Sync", True);
                if ToCompanies.FindSet then
                    repeat
                        ToDefaultDim.ChangeCompany(ToCompanies."Company Name");
                        ToDefaultDim.SetRange("Table ID", Database::"G/L Account");
                        ToDefaultDim.SetRange("No.", FromDefaultDim."No.");
                        ToDefaultDim.SetRange("Dimension Code", FromDefaultDim."Dimension Code");
                        if not ToDefaultDim.FindFirst() then begin
                            ToDefaultDim.TransferFields(FromDefaultDim);
                            if ToDefaultDim.Insert(true) then;
                        end;
                    until ToCompanies.Next = 0;
            until FromDefaultDim.Next = 0;


        Message('Master data transferred successfully.');
    end;

    var
        CompanyName: Text[100];
        Companies: Record Company;
        FromCustomerlist: Record Customer;
        ToCompanies: Record "MDS Companies";
        ToCustomer: Record Customer;
        FromVendorlist: Record Vendor;
        ToVendor: Record Vendor;
        FromItemlist: Record Item;
        ToItem: Record Item;
        FromGLAcclist: Record "G/L Account";
        ToGLAcclist: Record "G/L Account";
        CompanyInfo: Record "Company Information";
        FromVenBackAcc: Record "Vendor Bank Account";
        ToVenBackAcc: Record "Vendor Bank Account";
        FromDefaultDim: Record "Default Dimension";
        ToDefaultDim: Record "Default Dimension";
        FromItemUOM: Record "Item Unit of Measure";
        ToItemUOM: Record "Item Unit of Measure";
        FromLSCItemDist: Record "LSC Item Distribution";
        FromLSCItemScale: Record "LSC Item Scale";
        FromLSCKDSItemSectionRoutingt: Record "LSC KDS Item Section Routing";
        ToLSCKDSItemSectionRoutingt: Record "LSC KDS Item Section Routing";
        FromLSCBarcodes: Record "LSC Barcodes";
        FromLSCScaleFreeMsg: Record "LSC Scale Free Message";
        ToLSCItemDist: Record "LSC Item Distribution";
        ToLSCItemScale: Record "LSC Item Scale";
        ToLSCBarcodes: Record "LSC Barcodes";
        ToLSCScaleFreeMsg: Record "LSC Scale Free Message";
        FromSalesPrice: Record "Sales Price";
        ToSalesPrice: Record "Sales Price";

        xNo: Code[20];
}

