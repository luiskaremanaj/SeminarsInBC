codeunit 50131 "CSD SeminarJnl.-Check Line"
{
    TableNo = "CSD Seminar Journal Line";
    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    var
        GlSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ClosingDateTxt: Label 'cannot be a closing date.';
        PostingDateTxt: Label 'is not within your range of allowed posting dates.';

    procedure RunCheck(var SemJnlLine: Record "CSD Seminar Journal Line")
    var
        myInt: Integer;
    begin
        With SemJnlLine do begin
            if EmptyLine() then
                exit;


            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                if UserId <> '' then
                    if UserSetup.Get(UserId) then begin
                        AllowPostingFrom := UserSetup."Allow Posting From";
                        AllowPostingTo := UserSetup."Allow Posting To";
                    end;
                if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                    GlSetup.Get();
                    AllowPostingFrom := GlSetup."Allow Posting From";
                    AllowPostingTo := GlSetup."Allow Posting To";
                end;
                if AllowPostingTo = 0D then
                    AllowPostingTo := DMY2Date(31, 12, 9999);
            end;
            if ("Posting Date" < AllowPostingFrom) or ("Posting Date" > AllowPostingTo) then FieldError("Posting Date", PostingDateTxt);

            case
                "Charge Type" of
                "Charge Type"::Instructor:
                    Testfield("Instructor Resource No.");
                "Charge Type"::Room:
                    TestField("Room Resource No.");
                "Charge Type"::Participant:
                    TestField("Participant Contact No.");

            end;
            if Chargeable then
                TestField("Bill-to Customer No.");
            if "Posting Date" = ClosingDate("Posting Date") then
                FieldError("Posting Date", ClosingDateTxt);
            if ("Document Date" <> 0D) then
                if ("Document Date" = ClosingDate("Document Date")) then
                    FieldError("Document Date", PostingDateTxt);
        end;
    end;

}