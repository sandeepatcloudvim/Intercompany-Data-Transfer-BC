page 60501 "MDS Companies"
{

    ApplicationArea = Basic, Suite;
    Caption = 'MDS Companies';
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Navigate';
    RefreshOnActivate = true;
    SourceTable = "MDS Companies";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Name';
                    ToolTip = 'Specifies a Company Name.';
                }
                field("Include for Data Sync"; Rec."Include for Data Sync")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Include for Data Sync';
                    ToolTip = 'Specifies a Data Sync for the company.';
                }
                field("Overwrite Existing Data"; Rec."Overwrite Existing Data")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Overwrite Existing Data';
                    ToolTip = 'Specifies a Data Sync for the company.';
                }



            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {


    }

    trigger OnOpenPage()
    var
    begin
        recCompanyInfo.Get();
        Rec.UpdateCompmanyList(Rec.Type);
        Rec.SetFilter("Company Name", '<>%1', recCompanyInfo.Name);
    end;

    var
        recCompanyInfo: Record "Company Information";

}