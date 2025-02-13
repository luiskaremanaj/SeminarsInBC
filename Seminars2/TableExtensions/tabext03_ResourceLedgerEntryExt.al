tableextension 50103 "CSD ResourceLedgerEntryExt" extends "Res. Ledger Entry"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    // Chapter 7 - Lab 4-1
    fields
    {
        field(50100; "CSD Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
        }
        field(50101; "CSD Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Reg. Header';
            TableRelation = "CSD Seminar Reg. Header";
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}