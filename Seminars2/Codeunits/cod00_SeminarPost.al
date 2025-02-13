codeunit 50100 "CSD Seminar-Post"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 5-2
    //     - Created new codeunit

    TableNo = 50110;

    trigger OnRun();
    begin
        ClearAll();
        SeminarRegHeader := Rec;
        with SeminarRegHeader do begin
            TestField("Posting Date");
            TestField("Document Date");
            TestField("Seminar No.");
            TestField(Duration);
            TestField("Instructor Resource No.");
            TestField("Room Resource No.");
            TestField(Status, Status::Closed);
            SeminarRegLine.Reset();
            SeminarRegLine.SetRange("Document No.", "No.");
            if SeminarRegLine.IsEmpty then Error(Text001);
            Window.Open('#1###################\\' + Text002);
            window.Update(1, StrSubstNo('%1 %2', Text003, "No."));
            if SeminarRegHeader."Posting No." = '' then begin
                TestField("Posting No. Series");
                "Posting No." := NoSeriesMgt.GetNextNo("Posting No. Series", "Posting Date", true);
                Modify();
                Commit();
            end;
            SeminarRegLine.LockTable();
        end;
        Rec := SeminarRegHeader;

    end;

    var
        SeminarRegHeader: Record "CSD Seminar Reg. Header";
        SeminarRegLine: Record "CSD Seminar Registration Line";
        PstdSeminarRegHeader: Record "CSD Posted Seminar Reg. Header";
        PstdSeminarRegLine: Record "CSD Posted Seminar Reg. Line";
        SeminarCommentLine: Record "CSD Seminar Comment Line";
        SeminarCommentLine2: Record "CSD Seminar Comment Line";
        SeminarCharge: Record "CSD Seminar Charge";
        PstdSeminarCharge: Record "CSD Posted Seminar Charge";
        Room: Record Resource;
        Instructor: Record Resource;
        Customer: Record Customer;
        ResLedgEntry: Record "Res. Ledger Entry";
        SeminarJnlLine: Record "CSD Seminar Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        ResJnlLine: Record "Res. Journal Line";
        SeminarJnlPostLine: Codeunit "CSD Seminar Jnl.-Post Line";
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        SourceCode: Code[10];
        LineCount: Integer;
        Text001: Label 'There is no participant to post.';
        Text002: Label 'Posting lines              #2######\';
        Text003: Label 'Registration';
        Text004: Label 'Registration %1  -> Posted Reg. %2';
        Text005: Label 'The combination of dimensions used in %1 is blocked. %2';
        Text006: Label 'The combination of dimensions used in %1,  line no. %2 is blocked. %3';
        Text007: Label 'The dimensions used in %1 are invalid. %2';
        Text008: Label 'The dimensions used in %1, line no. %2 are invalid. %3';

    local procedure CopyCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]);
    begin
        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("Table Name", FromDocumentType);
        SeminarCommentLine.SetRange("No.", FromNumber);
        if SeminarCommentLine.FindSet() then
            repeat
                SeminarCommentLine2 := SeminarCommentLine;
                SeminarCommentLine2."Table Name" := ToDocumentType;
                SeminarCommentLine2."No." := ToNumber;
                SeminarCommentLine2.Insert();
            until SeminarCommentLine.Next() = 0;
    end;

    local procedure CopyCharges(FromNumber: Code[20]; ToNumber: Code[20]);
    begin
        SeminarCharge.Reset();
        SeminarCharge.SetRange("Document No.", FromNumber);
        if SeminarCharge.FindSet() then
            repeat
                PstdSeminarCharge.TransferFields(SeminarCharge);
                PstdSeminarCharge."Document No." := ToNumber;
                PstdSeminarCharge.Insert();
            until SeminarCharge.Next() = 0;
    end;

    local procedure PostResJnlLine(Resource: Record Resource): Integer;
    begin
        with SeminarRegHeader do begin
            ResJnlLine.Init();
            ResJnlLine."Entry Type" := ResJnlLine."Entry Type"::Usage;
            ResJnlLine."Document No." := PstdSeminarRegHeader."No.";
            ResJnlLine."Resource No." := Resource."No.";
            ResJnlLine."Posting Date" := "Posting Date";
            ResJnlLine."Reason Code" := "Reason Code";
            ResJnlLine.Description := "Seminar Name";
            ResJnlLine."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
            ResJnlLine."Posting No. Series" := "Posting No. Series";
            ResJnlLine."Source Code" := SourceCode;
            ResJnlLine."Resource No." := Resource."No.";
            ResJnlLine."Unit of Measure Code" := Resource."Base Unit of Measure";
            ResJnlLine."Unit Cost" := Resource."Unit Cost";
            ResJnlLine."Qty. per Unit of Measure" := 1;
            ResJnlLine.Quantity := Duration * Resource."CSD Quantity Per Day";
            ResJnlLine."Total Cost" := ResJnlLine."Unit Cost" * ResJnlLine.Quantity;
            ResJnlLine."CSD Seminar No." := "Seminar No.";
            ResJnlLine."CSD Seminar Registration No." := PstdSeminarRegHeader."No.";
            ResJnlPostLine.RunWithCheck(ResJnlLine);
        end;
        ResLedgEntry.FindLast();
        exit(ResLedgEntry."Entry No.");
    end;

    local procedure PostSeminarJnlLine(ChargeType: Option Instructor,Room,Participant,Charge);
    begin
        with SeminarRegHeader do begin
            SeminarJnlLine.Init();
            SeminarJnlLine."Seminar No." := "Seminar No.";
            SeminarJnlLine."Posting Date" := "Posting Date";
            SeminarJnlLine."Document Date" := "Document Date";
            SeminarJnlLine."Document No." := PstdSeminarRegHeader."No.";
            SeminarJnlLine."Charge Type" := ChargeType;
            SeminarJnlLine."Instructor Resource No." := "Instructor Resource No.";
            SeminarJnlLine."Starting Date" := "Starting Date";
            SeminarJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
            SeminarJnlLine."Room Resource No." := "Room Resource No.";
            SeminarJnlLine."Source Type" := SeminarJnlLine."Source Type"::Seminar;
            SeminarJnlLine."Source No." := "Seminar No.";
            SeminarJnlLine."Source Code" := SourceCode;
            SeminarJnlLine."Reason Code" := "Reason Code";
            SeminarJnlLine."Posting No. Series" := "Posting No. Series";
            case ChargeType of
                ChargeType::Instructor:
                    begin
                        Instructor.get("Instructor Resource No.");
                        SeminarJnlLine.Description := Instructor.Name;
                        SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                        SeminarJnlLine.Chargeable := false;
                        SeminarJnlLine.Quantity := Duration;
                        SeminarJnlLine."Res. Ledger Entry No." := PostResJnlLine(Instructor);
                    end;

                ChargeType::Room:
                    begin
                        Room.get("Room Resource No.");
                        SeminarJnlLine.Description := Room.Name;
                        SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                        SeminarJnlLine.Chargeable := false;
                        SeminarJnlLine.Quantity := Duration;
                        SeminarJnlLine."Res. Ledger Entry No." := PostResJnlLine(Room);
                    end;

                ChargeType::Participant:
                    begin
                        SeminarJnlLine."Bill-to Customer No." := SeminarRegLine."Bill-to Customer No.";
                        SeminarJnlLine."Participant Contact No." := SeminarRegLine."Participant Contact No.";
                        SeminarJnlLine."Participant Name" := SeminarRegLine."Participant Name";
                        SeminarJnlLine.Description := SeminarRegLine."Participant Name";
                        SeminarJnlLine.Chargeable := SeminarRegLine."To Invoice";
                        SeminarJnlLine."Unit Price" := SeminarRegLine.Amount;
                        SeminarJnlLine."Total Price" := SeminarRegLine.Amount;
                        SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                        SeminarJnlLine.Quantity := 1;
                    end;

                ChargeType::Charge:
                    begin
                        SeminarJnlLine.Description := SeminarCharge.Description;
                        SeminarJnlLine."Bill-to Customer No." := SeminarCharge."Bill-to Customer No.";
                        SeminarJnlLine.Type := SeminarCharge.Type;
                        SeminarJnlLine.Quantity := SeminarCharge.Quantity;
                        SeminarJnlLine."Unit Price" := SeminarCharge."Unit Price";
                        SeminarJnlLine."Total Price" := SeminarCharge."Total Price";
                        SeminarJnlLine.Chargeable := SeminarCharge."To Invoice";
                    end;


            end;

            SeminarJnlPostLine.RunWithCheck(SeminarJnlLine);
        end;
    end;

    procedure PostCharges();
    var
        SourceCodeSetup: Record "Source Code Setup";
        PstdSeminarRegHeader: Record "CSD Posted Seminar Reg. Header";
    begin
        SourceCodeSetup.Get();
        SourceCode := SourceCodeSetup."CSD Seminar";
        PstdSeminarRegHeader.Init();
        PstdSeminarRegHeader.TransferFields(SeminarRegHeader);
        PstdSeminarRegHeader."No." := SeminarRegHeader."Posting No.";
        PstdSeminarRegHeader."No. Series" := SeminarRegHeader."Posting No. Series";
        PstdSeminarRegHeader."Source Code" := SourceCode;
        PstdSeminarRegHeader."User ID" := UserId;
        SeminarRegHeader.Insert();
        Window.Update(1, StrSubstNo(Text004, PstdSeminarRegHeader."No.", SeminarRegHeader."No."));
        CopyCommentLines(
            SeminarCommentLine."Table Name"::"Seminar Registration",
            SeminarCommentLine."Table Name"::"Posted Seminar Registration", SeminarRegHeader."No.", PstdSeminarRegHeader."No.");
        CopyCharges(SeminarRegHeader."No.", PstdSeminarRegHeader."No.");
        LineCount := 0;
        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Document No.", SeminarRegHeader."No.");
        if SeminarRegLine.FindSet() then begin
            repeat
                LineCount += 1;
                Window.Update(2, LineCount);
                SeminarRegLine.TestField("Bill-to Customer No.");
                SeminarRegLine.TestField("Participant Contact No.");
                if not SeminarRegLine."To Invoice" then begin
                    SeminarRegLine."Seminar Price" := 0;
                    SeminarRegLine."Line Discount %" := 0;
                    SeminarRegLine."Line Discount Amount" := 0;
                    SeminarRegLine.Amount := 0;
                end;
                PostSeminarJnlLine(2);
                PstdSeminarRegLine.Init();
                PstdSeminarRegLine.TransferFields(SeminarRegLine);
                PstdSeminarRegLine."Document No." := PstdSeminarRegHeader."No.";
                PstdSeminarRegLine.Insert();

            until SeminarRegLine.Next() = 0;

        end;
        PostCharges();
        PostSeminarJnlLine(0); // instructor
        PostSeminarJnlLine(1); // room

        SeminarCharge.Reset();
        SeminarCharge.SetRange("Document No.", SeminarRegHeader."No.");
        if SeminarCharge.FindSet(false, false) then
            repeat
                PostSeminarJnlLine(3);
            until SeminarCharge.next = 0;

        //delete reg header, lines, comm, charges 
        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Document No.", SeminarRegHeader."No.");
        if SeminarRegLine.FindSet() then
            repeat
                SeminarRegLine.Delete(true);
            until SeminarRegLine.Next() = 0;

        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("No.", SeminarRegHeader."No.");
        if SeminarCommentLine.FindSet() then
            repeat
                SeminarCommentLine.Delete(true);
            until SeminarCommentLine.Next() = 0;

        SeminarCharge.Reset();
        SeminarCharge.SetRange("Document No.", SeminarRegHeader."No.");
        if SeminarCharge.FindSet() then
            repeat
                SeminarCharge.Delete(true);
            until SeminarCharge.Next() = 0;

        SeminarRegHeader.Delete(true);
    end;
}

