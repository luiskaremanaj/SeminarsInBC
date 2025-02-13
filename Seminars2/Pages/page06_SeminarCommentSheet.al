page 50106 "CSD Seminar Comment Sheet"
{
    Caption = 'Seminar Comment Sheet';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar Comment Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {

                }
                field(Code; Rec.Code)
                {
                    Visible = false;

                }
                field(Comment; Rec.Comment)
                {

                }
            }
        }

    }



    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetupNewLine();
    end;
}