page 50134 "CSD Posted Seminar Reg."
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 3
    //     - Created new page

    Caption = 'Seminar Registration';
    Editable = false;
    PageType = Document;
    SourceTable = "CSD Posted Seminar Reg. Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                }
            }
            part(SeminarRegistrationLines; 50135)
            {
                SubPageLink = "Document No." = Field("No.");
            }
            group("Seminar Room")
            {
                field("Room Resource No."; Rec."Room Resource No.")
                {
                }
                field("Room Name"; Rec."Room Name")
                {
                }
                field("Room Address"; Rec."Room Address")
                {
                }
                field("Room Address 2"; Rec."Room Address 2")
                {
                }
                field("Room Post Code"; Rec."Room Post Code")
                {
                }
                field("Room City"; Rec."Room City")
                {
                }
                field("Room Country/Reg. Code"; Rec."Room Country/Reg. Code")
                {
                }
                field("Room County"; Rec."Room County")
                {
                }
            }
            group(Invoicing)
            {
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                }
            }
        }
        area(factboxes)
        {
            part(SeminarDetails; 50117)
            {
                SubPageLink = "No." = Field("Seminar No.");
            }
            part(SeminarRegLines; 9084)
            {
                Provider = SeminarRegistrationLines;
                SubPageLink = "No." = Field("Bill-to Customer No.");
            }
            systempart(Links; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }
        }
    }
    // chapter 8 2-4
    // added Action Navigate
    actions
    {
        area(Processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."No.");
                    Navigate.Run();
                end;
            }
        }
        area(navigation)
        {
            group("&Seminar Registration")
            {
                Caption = '&Seminar Registration';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page 50106;
                    RunPageLink = "No." = Field("No.");
                    RunPageView = where("Table Name" = const("Posted Seminar Registration"));
                }
                action("&Charges")
                {
                    Caption = '&Charges';
                    Image = Costs;
                    RunObject = Page 50139;
                    RunPageLink = "Document No." = Field("No.");
                }
            }
        }
    }
}

