page 50100 "CSD Seminar Setup"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar Setup";
    Caption = 'Seminar Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;




    layout
    {
        area(Content)
        {
            repeater(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {

                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.") { }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.") { }

            }
        }

    }






    trigger OnOpenPage();
    begin
        if not Rec.get then begin
            Rec.init;
            Rec.insert;

        end
    end;

}