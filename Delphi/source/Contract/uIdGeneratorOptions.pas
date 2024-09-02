unit uIdGeneratorOptions;

interface

uses
  System.DateUtils, System.SysUtils;

type
  TIdGeneratorOptions = class
  private
    FMethod: SmallInt;
    // FBaseTime: TDateTime;
    FBaseTime: Int64;
    FWorkerId: Word;
    FWorkerIdBitLength: Byte;
    FSeqBitLength: Byte;
    FMaxSeqNumber: Integer;
    FMinSeqNumber: Word;
    FTopOverCostCount: Integer;
    FDataCenterId: Cardinal;
    FDataCenterIdBitLength: Byte;
    FTimestampType: Byte;
  public
    /// <summary>
    /// ѩ�����㷽��
    /// ��1-Ư���㷨|2-��ͳ�㷨����Ĭ��1
    /// </summary>
    property Method: SmallInt read FMethod write FMethod default 1;
    /// <summary>
    /// ����ʱ�䣨UTC��ʽ��
    /// ���ܳ�����ǰϵͳʱ��
    /// </summary>
    // property BaseTime: TDateTime read FBaseTime write FBaseTime;
    property BaseTime: Int64 read FBaseTime write FBaseTime;
    /// <summary>
    /// ������
    /// �������ⲿ�趨�����ֵ 2^WorkerIdBitLength-1
    /// </summary>
    property WorkerId: Word read FWorkerId write FWorkerId default 0;
    /// <summary>
    /// ������λ��
    /// Ĭ��ֵ6��ȡֵ��Χ [1, 15]��Ҫ��������λ��+������λ��������22��
    /// </summary>
    property WorkerIdBitLength: Byte read FWorkerIdBitLength write FWorkerIdBitLength default 6; // 10;
    /// <summary>
    /// ������λ��
    /// Ĭ��ֵ6��ȡֵ��Χ [3, 21]��Ҫ��������λ��+������λ��������22��
    /// </summary>
    property SeqBitLength: Byte read FSeqBitLength write FSeqBitLength default 6; // 10;
    /// <summary>
    /// ���������������
    /// ���÷�Χ [MinSeqNumber, 2^SeqBitLength-1]��Ĭ��ֵ0����ʾ���������ȡ���ֵ��2^SeqBitLength-1]��
    /// </summary>
    property MaxSeqNumber: Integer read FMaxSeqNumber write FMaxSeqNumber default 0;
    /// <summary>
    /// ��С������������
    /// Ĭ��ֵ5��ȡֵ��Χ [5, MaxSeqNumber]��ÿ�����ǰ5����������Ӧ���0-4�Ǳ���λ������1-4��ʱ��ز���ӦԤ��λ��0���ֹ���ֵԤ��λ
    /// </summary>
    property MinSeqNumber: Word read FMinSeqNumber write FMinSeqNumber default 5;
    /// <summary>
    /// ���Ư�ƴ�����������
    /// Ĭ��2000���Ƽ���Χ500-10000������������йأ�
    /// </summary>
    property TopOverCostCount: Integer read FTopOverCostCount write FTopOverCostCount default 2000;
    /// <summary>
    /// ��������ID��Ĭ��0��
    /// </summary>
    property DataCenterId: Cardinal read FDataCenterId write FDataCenterId default 0;
    /// <summary>
    /// ��������ID���ȣ�Ĭ��0��
    /// </summary>
    property DataCenterIdBitLength: Byte read FDataCenterIdBitLength write FDataCenterIdBitLength default 0;
    /// <summary>
    /// ʱ������ͣ�0-���룬1-�룩��Ĭ��0
    /// </summary>
    property TimestampType: Byte read FTimestampType write FTimestampType default 0;

    constructor Create(); overload;
    constructor Create(WorkerId: Word); overload;
  end;

implementation

{ TIdGeneratorOptions }

constructor TIdGeneratorOptions.Create(WorkerId: Word);
begin
  FBaseTime := 1582136402000; // EncodeDateTime(2020, 2, 20, 2, 20, 2, 20);
  FWorkerId := WorkerId;
end;

constructor TIdGeneratorOptions.Create();
begin
  FBaseTime := 1582136402000; // EncodeDateTime(2020, 2, 20, 2, 20, 2, 20);
end;

end.
