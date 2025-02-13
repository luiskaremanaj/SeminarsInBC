page 50141 " CSD My Seminars"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "My Seminar";
    Caption = 'My Seminars';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Seminar No."; Rec."Seminar No.")
                {

                }
                field(Name; Seminar.Name)
                {

                }
                field(Duration; Seminar."Seminar Duration")
                {

                }
                field(Price; Seminar."Seminar Price")
                {

                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(Open)
            {

                trigger OnAction();
                begin
                    OpenSeminarCard;
                end;
            }
        }
    }
    var
        Seminar: Record "CSD Seminar";

    trigger OnOpenPage();
    begin
        Rec.SetRange("User ID", UserId);
    end;

    trigger OnAfterGetRecord();
    begin
        if Seminar.Get(Rec."Seminar No.") then;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Clear(Seminar);

    end;

    local procedure OpenSeminarCard();
    begin
        if Seminar."No." <> '' then
            Page.Run(Page::"CSD Seminar Card", Seminar);
    end;

}