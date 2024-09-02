unit uSnowWorkerM3;

interface

uses System.SysUtils, System.DateUtils, uSnowWorkerM1, uIdGeneratorOptions, System.SyncObjs;

/// <summary>
/// ѩ��Ư���㷨��֧����������ID���뼶ʱ�����
/// </summary>
type
  TSnowWorkerM3 = class(TSnowWorkerM1)
  protected
    FDataCenterId: Cardinal;
    FDataCenterIdBitLength: Byte;
    FTimestampType: Byte;
  protected
    /// <summary>
    /// ��������ID��Ĭ��0��
    /// </summary>
    property DataCenterId: Cardinal read FDataCenterId default 0;
    /// <summary>
    /// ��������ID���ȣ�Ĭ��0��
    /// </summary>
    property DataCenterIdBitLength: Byte read FDataCenterIdBitLength default 0;
    /// <summary>
    /// ʱ������ͣ�0-���룬1-�룩��Ĭ��0
    /// </summary>
    property TimestampType: Byte read FTimestampType default 0;
  protected
    function CalcId(UseTimeTick: Int64): Int64; override;
    function CalcTurnBackId(UseTimeTick: Int64): Int64; override;
    function GetCurrentTimeTick(): Int64; override;
  public
    constructor Create(options: TIdGeneratorOptions); overload;
  end;

implementation

{ TSnowWorkerM3 }

constructor TSnowWorkerM3.Create(options: TIdGeneratorOptions);
begin
  // �뼶ʱ�������
  FTimestampType := options.TimestampType;

  // DataCenter���
  FDataCenterId := options.DataCenterId;
  FDataCenterIdBitLength := options.DataCenterIdBitLength;

  if (FTimestampType = 1) then
  begin
    FTopOverCostCount := 0;
  end;
  FTimestampShift := Byte(DataCenterIdBitLength + WorkerIdBitLength + SeqBitLength);

  inherited Create(options);
end;

function TSnowWorkerM3.CalcId(UseTimeTick: Int64): Int64;
begin
  Result := ((UseTimeTick shl FTimestampShift) + (Int64(DataCenterId) shl DataCenterIdBitLength) +
    (Int64(WorkerId) shl SeqBitLength) + Int64(FCurrentSeqNumber));

  Inc(FCurrentSeqNumber);
end;

function TSnowWorkerM3.CalcTurnBackId(UseTimeTick: Int64): Int64;
begin
  Result := ((UseTimeTick shl FTimestampShift) + (Int64(DataCenterId) shl DataCenterIdBitLength) +
    (Int64(WorkerId) shl SeqBitLength) + FTurnBackIndex);

  Dec(FTurnBackTimeTick);
end;

function TSnowWorkerM3.GetCurrentTimeTick: Int64;
var
  Millis: Int64;
begin
  if (TimestampType = 0) then
  begin
    Millis := GetMillisecondTimeStamp();
    Result := Millis - FBaseTime;
  end
  else
  begin
    Millis := GetSecondTimeStamp();
    Result := Millis - FBaseTime;
  end;
end;

end.
