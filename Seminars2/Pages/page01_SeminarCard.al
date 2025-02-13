page 50101 "CSD Seminar Card"
{
    Caption = 'Seminar';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar";

    layout
    {
        area(Content)
        {
            group(General)
            {


                field("No."; Rec."No.")
                {
                    AssistEdit = true;

                    trigger OnAssistEdit();

                    begin
                        if Rec.AssistEdit then
                            CurrPage.Update();

                    end;
                }
                field("Name"; Rec."Name")
                {

                }
                field("Search Name"; Rec."Search Name")
                {

                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {

                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {

                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {

                }
                field("Blocked"; Rec."Blocked")
                {

                }
                field("Last Date Modified"; Rec."Last Date Modified")
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
        area(FactBoxes)
        {
            systempart("Links"; Links)
            {

            }
            systempart("Notes"; Notes)
            {

            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Seminar")
            {
                action("Co&mments")
                {

                    RunObject = page "CSD Seminar Comment Sheet";
                    RunPageLink = "Table Name" = const("Seminar"), "No." = field("No.");
                    Image = Comment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                }
                // lab 8 1-2
                action("Ledget Entries")
                {
                    Caption = 'Ledger Entries';
                    RunObject = page "CSD Seminar Ledger Entries";
                    RunPageLink = "Seminar No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortcutKey = "Ctrl+F7";
                    Image = WarrantyLedger;

                }

                action("&Registrations")
                {
                    Caption = '&Registrations';
                    RunObject = page "CSD Seminar Registration List";
                    RunPageLink = "Seminar No." = field("No.");
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;

                }




            }
        }
        area(Processing)
        {
            action("Seminar Registration")
            {
                RunObject = page "CSD Seminar Registration";
                RunPageLink = "Seminar No." = field("No.");
                RunPageMode = Create;
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = New;

            }
        }
        // << lab 8 1-2   
    }



}