unit uYitIdHelper;

interface

uses System.SysUtils, uIIdGenerator, uIdGeneratorOptions;

type
  TYitIdHelper = class
  private
    IdGenInstance: IIdGenerator;
  public
    function GetIdGenInstance(): IIdGenerator;
    /// <summary>
    /// ���ò�������������ʼ��ʱִ��һ��
    /// </summary>
    /// <param name="options"></param>
    procedure SetIdGenerator(options: TIdGeneratorOptions);
    /// <summary>
    /// �����µ�Id
    /// ���ñ�����ǰ����ȷ�������� SetIdGenerator ��������ʼ����
    /// </summary>
    /// <returns></returns>
    function NextId(): Int64;
  end;

implementation

uses
  uDefaultIdGenerator;

{ TYitIdHelper }

function TYitIdHelper.GetIdGenInstance: IIdGenerator;
begin
  Result := IdGenInstance;
end;

procedure TYitIdHelper.SetIdGenerator(options: TIdGeneratorOptions);
begin
  IdGenInstance := TDefaultIdGenerator.Create(options);
end;

function TYitIdHelper.NextId(): Int64;
begin
  if (IdGenInstance = nil) then
    raise Exception.Create('Please initialize Yitter.IdGeneratorOptions first.');

  Result := IdGenInstance.NewLong();
end;

end.
