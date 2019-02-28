codeunit 50100 "Extension Install"
{
    Subtype = Install;

    local procedure ConfigureEdmTypes();
    var
        ODataEdmType: Record "OData Edm Type";
        Stream: OutStream;
        EdmKey: Label 'VJEKO.ENGINE', Locked = true;
        EdmDescription: Label 'Vjeko.Engine type for Vehicle Management extension';
        EdmDefinition: Label '<ComplexType Name="engineType"><Property Name="type" Type="Edm.String" Nullable="true" /><Property Name="power" Type="Edm.Decimal" Nullable="true" /><Property Name="displacement" Type="Edm.Decimal" Nullable="true" /></ComplexType>', Locked = true;

    begin
        with ODataEdmType do begin
            Key := EdmKey;
            if Find() then
                exit;

            Init();
            Description := EdmDescription;
            "Edm Xml".CreateOutStream(Stream);
            Stream.WriteText(EdmDefinition);
            Insert();
        end;
    end;

    trigger OnInstallAppPerDatabase();
    begin
        ConfigureEdmTypes();
    end;
}