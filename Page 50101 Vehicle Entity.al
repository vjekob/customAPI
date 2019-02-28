page 50101 "Vehicle Entity"
{
    Caption = 'vehicles';
    PageType = API;
    SourceTable = Vehicle;
    DelayedInsert = true;
    APIPublisher = 'vjeko';
    APIGroup = 'demos';
    APIVersion = 'beta';
    EntityName = 'vehicle';
    EntitySetName = 'vehicles';
    ODataKeyFields = Id;

    layout
    {
        area(Content)
        {
            repeater(Vehicles)
            {
                field(id; Id)
                {
                    Caption = 'id';
                    ApplicationArea = All;
                }

                field(code; Code)
                {
                    Caption = 'code';
                    ApplicationArea = All;
                }

                field(make; Make)
                {
                    Caption = 'make';
                    ApplicationArea = All;
                }

                field(model; Model)
                {
                    Caption = 'model';
                    ApplicationArea = All;
                }

                field(year; Year)
                {
                    Caption = 'year';
                    ApplicationArea = All;
                }

                field(registrationPlate; "Registration Plate")
                {
                    Caption = 'registrationPlate';
                    ApplicationArea = All;
                }

                field(engine; EngineJSON)
                {
                    Caption = 'engine';
                    ApplicationArea = All;
                    ODataEDMType = 'VJEKO.ENGINE';
                }

                field(lastModifiedDateTime; "Last Modified Date Time")
                {
                    Caption = 'lastModifiedDateTime';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        EngineJSON: Text;

    local procedure SetEngineJSON();
    var
        JObject: JsonObject;
    begin
        JObject.Add('type', Format("Engine Type"));
        JObject.Add('power', Format("Engine Power"));
        JObject.Add('displacement', Format("Engine Displacement"));
        JObject.WriteTo(EngineJSON);
    end;

    local procedure ClearEngineJSON();
    begin
        Clear(EngineJSON);
    end;

    local procedure ProcessEngineJSON();
    var
        JObject: JsonObject;
        JToken: JsonToken;
    begin
        JObject.ReadFrom(EngineJSON);

        if JObject.Get('type', JToken) then
            Evaluate("Engine Type", JToken.AsValue().AsText());

        if JObject.Get('power', JToken) then
            Evaluate("Engine Power", JToken.AsValue().AsText());

        if JObject.Get('displacement', JToken) then
            Evaluate("Engine Displacement", JToken.AsValue().AsText());
    end;

    trigger OnAfterGetRecord();
    begin
        SetEngineJSON();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        ClearEngineJSON();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Insert(true);
        ProcessEngineJSON();
        Modify(true);
        SetEngineJSON();
        exit(false);
    end;

    trigger OnModifyRecord(): Boolean;
    var
        Vehicle: Record Vehicle;
        ErrorIdImmutable: Label 'Value of Id is immutable.';
    begin
        if xRec.Id <> Id then
            Error(ErrorIdImmutable);

        ProcessEngineJSON();

        Vehicle.SetRange(Id, Id);
        Vehicle.FindFirst();
        if Vehicle.Code <> Code then begin
            Vehicle.TransferFields(Rec);
            Vehicle.Rename(Code);
            TransferFields(Vehicle);
        end else
            Modify(true);

        SetEngineJSON();
    end;
}