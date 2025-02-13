pageextension 50100 "CSD ResourceCardExt" extends "Resource Card"
{
    layout
    {
        addlast(General)
        {

            field("CSD Resource Type"; Rec."CSD Resource Type")
            {

            }

            field("CSD Quantity Per Day"; Rec."CSD Quantity Per Day")
            {

            }


        }

        addafter("Personal Data")
        {
            group("CSD Room")
            {

                Caption = 'Room';
                Visible = ShowMaxField;
                field("CSD Maximum Participants"; Rec."CSD Maximum Participants")
                {

                }
            }
        }


    }


    trigger OnAfterGetRecord();
    begin
        ShowMaxField := (Rec.Type = Rec.Type::Machine);
        CurrPage.Update(false);
    end;


    var
        [InDataSet]
        ShowMaxField: Boolean;

}