pageextension 50102 "CSD SourceCodeSetupExt" extends "Source Code Setup"
{
    layout
    {
        addafter("Cost Accounting")
        {
            group("CSD SeminarGroup")
            {
                Caption = 'Seminar';
                field(Seminar; Rec."CSD Seminar")
                {

                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}