page 50140 "CSD Seminar Manager Activities"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar Cue";
    Caption = 'CSD Seminar Manager Activities';
    Editable = false;


    layout
    {
        area(Content)
        {
            cuegroup(Registration)
            {
                Caption = 'Registration';
                field(Planned; Rec.Planned)
                {
                }
                field(Registered; Rec.Registered)
                {

                }
                actions
                {
                    action(New)
                    {
                        Caption = 'New';
                        RunObject = page "CSD Seminar Registration";
                        RunPageMode = Create;
                    }

                }
            }
            cuegroup("For Posting")
            {
                Caption = 'For Posting';
                field(Closed; Rec.Closed)
                {

                }
            }
        }
    }



    trigger OnOpenPage();
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}