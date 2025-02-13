table 50118 "CSD Posted Seminar Reg. Header"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 6 - Lab 1-3 & Lab 1-4
    //     - Created new table
    Caption = 'CSD Posted Seminar Reg. Header';
    LookupPageId = "CSD Posted Seminar Reg. List";
    DrillDownPageId = "CSD Posted Seminar Reg. List";
    // chapter 8 - lab 2-3
    // added lookupid and drilldownpageid properties
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";


        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
        }
        field(5; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            TableRelation = Resource where(Type = const(Person));


        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            CalcFormula = Lookup(Resource.Name where("No." = Field("Instructor Resource No."),
                                                      Type = const(Person)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Planning,Registration,Closed,Canceled';
            OptionMembers = Planning,Registration,Closed,Canceled;
        }
        field(8; Duration; Decimal)
        {
            Caption = 'Duration';
            DecimalPlaces = 0 : 1;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(11; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            TableRelation = Resource where(Type = const(Machine));


        }
        field(12; "Room Name"; Text[30])
        {
            Caption = 'Room Name';
        }
        field(13; "Room Address"; Text[30])
        {
            Caption = 'Room Adress';
        }
        field(14; "Room Address 2"; Text[30])
        {
            Caption = 'Room Adress 2';
        }
        field(15; "Room Post Code"; Code[20])
        {
            Caption = 'Room Post Code';
            TableRelation = "Post Code".Code;
            ValidateTableRelation = false;


        }
        field(16; "Room City"; Text[30])
        {
            Caption = 'Room City';


        }
        field(17; "Room Country/Reg. Code"; Code[10])
        {
            Caption = 'Room Country/Reg. Code';
            TableRelation = "Country/Region";
        }
        field(18; "Room County"; Text[30])
        {
            Caption = 'Room County';
        }
        field(19; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;


        }
        field(20; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(21; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(22; Comment; Boolean)
        {
            Caption = 'Comment';
            CalcFormula = Exist("CSD Seminar Comment Line" where("Table Name" = const("Posted Seminar Registration"),
                                                              "No." = Field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(24; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(25; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code".Code;
        }
        field(26; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series".Code;
        }
        field(27; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series".Code;
        }
        field(29; "User ID"; code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
            ValidateTableRelation = false;
        }
        field(30; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }

    }

    keys
    {
        key(PK; "No.")
        {
        }
        key(Key2; "Room Resource No.")
        {
            SumIndexFields = Duration;
        }
    }

    // var
    //     PostCode: Record "Post Code";
    //     Seminar: Record "CSD Seminar";
    //     SeminarCommentLine: Record "CSD Seminar Comment Line";
    //     SeminarCharge: Record "CSD Seminar Charge";
    //     SeminarRegHeader: Record "CSD Seminar Reg. Header";
    //     SeminarRegLine: Record "CSD Seminar Registration Line";
    //     SeminarRoom: Record Resource;
    //     SeminarSetup: Record "CSD Seminar Setup";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    //     Text001: Label 'You cannot delete the Seminar Registration, because there is at least one %1 where %2=%3.';
    //     Text002: Label 'You cannot change the %1, because there is at least one %2 with %3=%4.';
    //     Text004: Label 'This Seminar is for %1 participants. \The selected Room has a maximum of %2 participants \Do you want to change %3 for the Seminar from %4 to %5?';
    //     Text005: Label 'Should the new %1 be copied to all %2 that are not yet invoiced?';
    //     Text006: Label 'You cannot delete the Seminar Registration, because there is at least one %1.';








}

