pageextension 50101 "CSD ResourceListExt" extends "Resource List"
{
    layout
    {
        modify(Type)
        {
            Visible = ShowType;
        }
        addafter(Type)
        {
            field("CSD Resource Type"; Rec."CSD Resource Type") { }
            field("CSD Maximum Participants"; Rec."CSD Maximum Participants")
            {
                Visible = ShowMaxField;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Showtype := (Rec.GetFilter(Type) = '');
        ShowMaxField := (Rec.GetFilter(Type) = format(Rec.Type::Machine));
    end;

    var
        [InDataSet]
        Showtype: Boolean;
        [InDataSet]
        ShowMaxField: Boolean;
}