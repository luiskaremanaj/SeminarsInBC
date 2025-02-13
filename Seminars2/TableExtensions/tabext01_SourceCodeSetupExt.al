tableextension 50101 "CSD SourceCodeSetupExt" extends "Source Code Setup"
{
    fields
    {
        field(50100; "CSD Seminar"; Code[10])
        {
            Caption = 'CSD Seminar';
            TableRelation = "Source Code";
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