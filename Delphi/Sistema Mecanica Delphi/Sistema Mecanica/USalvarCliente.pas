unit USalvarCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ADODB, DB, Buttons;

type
  TfrmIncluirCliente = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtNome: TEdit;
    lblCpf: TLabel;
    maskCpf: TMaskEdit;
    Label2: TLabel;
    maskTelefone: TMaskEdit;
    Label3: TLabel;
    edtEndereco: TEdit;
    Label4: TLabel;
    maskNumero: TMaskEdit;
    Label5: TLabel;
    edtCidade: TEdit;
    Label6: TLabel;
    cboEstado: TComboBox;
    ADOCommand: TADOCommand;
    btSalvar: TBitBtn;
    btSair: TBitBtn;
    ADODataSetConfirm: TADODataSet;
    edtEmail: TEdit;
    Label7: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure maskNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure edtEnderecoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure cboEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure btSalvarClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIncluirCliente: TfrmIncluirCliente;

implementation

uses UFormMain, UClientes;

{$R *.dfm}

procedure TfrmIncluirCliente.btnSairClick(Sender: TObject);
begin
  frmClientes.ADODataSetGrid.Active := false;
  frmClientes.ADODataSetGrid.CommandText := 'select top 100 id, cpf, nome from cliente order by id desc';
  frmClientes.ADODataSetGrid.Active := true;
  frmClientes.edtNomeCpf.SetFocus;
  Close;
end;

procedure TfrmIncluirCliente.btnIncluirClick(Sender: TObject);
var
  sql : string;
  valido : boolean;
begin
  valido := true;

  if trim( edtNome.Text ) = '' then
  begin
     MessageDlg('Digite o Nome',mtinformation, [mbOK], 0);
     valido := false;
     edtNome.SetFocus;
  end;

  if (trim( maskCpf.Text ) = '') or (trim( maskCpf.Text ) = '.   .   -') then
  begin
     MessageDlg('Digite o CPF',mtinformation, [mbOK], 0);
     valido := false;
     maskCpf.SetFocus;
  end;

  if (trim( maskTelefone.Text ) = '') or (trim( maskTelefone.Text ) = '(   )    -') then
  begin
     MessageDlg('Digite o Telefone',mtinformation, [mbOK], 0);
     valido := false;
     maskTelefone.SetFocus;
  end;

  if trim( edtEndereco.Text ) = '' then
  begin
     MessageDlg('Digite o Endere�o',mtinformation, [mbOK], 0);
     valido := false;
     edtEndereco.SetFocus;
  end;

  if trim( maskNumero.Text ) = '' then
  begin
     MessageDlg('Digite o N�mero',mtinformation, [mbOK], 0);
     valido := false;
     maskNumero.SetFocus;
  end;

  if trim( edtCidade.Text ) = '' then
  begin
     MessageDlg('Digite o Cidade',mtinformation, [mbOK], 0);
     valido := false;
     edtCidade.SetFocus;
  end;

  if trim( cboEstado.Text ) = '' then
  begin
     MessageDlg('Digite o Estado',mtinformation, [mbOK], 0);
     valido := false;
     cboEstado.SetFocus;
  end;

  if valido then
  begin
    sql := 'insert into cliente( nome, cpf, telefone, endereco, numero, cidade, estado )values(';
    sql := sql + '"' + edtNome.Text + '", "' + maskCpf.Text + '", "' + maskTelefone.Text + '",';
    sql := sql + '"' + edtEndereco.Text + '", "' + maskNumero.Text + '", "' + edtCidade.Text + '", "' + cboEstado.Text + '" )';

    ADOCommand.CommandText := sql;
    ADOCommand.Execute;

    MessageDlg('Cliente incluido com sucesso.',mtinformation, [mbOK], 0);

    edtNome.Text := '';
    maskCpf.Text := '';
    maskTelefone.Text := '';
    edtEndereco.Text := '';
    edtCidade.Text := '';
    cboEstado.Text := '';
    maskNumero.Text := '';
  end;
end;

procedure TfrmIncluirCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmClientes.ADODataSetGrid.Active := false;
  frmClientes.ADODataSetGrid.CommandText := 'select top 100 id, cpf, nome from cliente order by id desc';
  frmClientes.ADODataSetGrid.Active := true;
  frmClientes.edtNomeCpf.SetFocus;
end;

procedure TfrmIncluirCliente.maskNumeroKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key in ['0'..'9','.',#8]=false then
    key:=#13;
end;

procedure TfrmIncluirCliente.edtEnderecoKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key:=UpCase( Key )
end;

procedure TfrmIncluirCliente.edtCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key:=UpCase( Key )
end;

procedure TfrmIncluirCliente.cboEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key:=UpCase( Key )
end;

procedure TfrmIncluirCliente.edtNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key:=UpCase( Key )
end;

procedure TfrmIncluirCliente.btSalvarClick(Sender: TObject);
var
  sql : string;
  valido : boolean;
begin
  valido := true;

  ADODataSetConfirm.Active := false;
  ADODataSetConfirm.CommandText := 'select id from cliente where cpf="' + maskCpf.Text + '"';
  ADODataSetConfirm.Active := true;

  try
    if not ADODataSetConfirm.Eof then
    begin
       MessageDlg('CPF de cliente j� cadastrado',mtError, [mbOK], 0);
    end
    else
    begin
        if trim( edtNome.Text ) = '' then
        begin
           MessageDlg('Digite o Nome',mtinformation, [mbOK], 0);
           valido := false;
           edtNome.SetFocus;
        end;

        if (trim( maskCpf.Text ) = '') or (trim( maskCpf.Text ) = '.   .   -') then
        begin
           MessageDlg('Digite o CPF',mtinformation, [mbOK], 0);
           valido := false;
           maskCpf.SetFocus;
        end;

        if (trim( maskTelefone.Text ) = '') or (trim( maskTelefone.Text ) = '(   )    -') then
        begin
           MessageDlg('Digite o Telefone',mtinformation, [mbOK], 0);
           valido := false;
           maskTelefone.SetFocus;
        end;

        if trim( edtEndereco.Text ) = '' then
        begin
           MessageDlg('Digite o Endere�o',mtinformation, [mbOK], 0);
           valido := false;
           edtEndereco.SetFocus;
        end;

        if trim( maskNumero.Text ) = '' then
        begin
           MessageDlg('Digite o N�mero',mtinformation, [mbOK], 0);
           valido := false;
           maskNumero.SetFocus;
        end;

        if trim( edtCidade.Text ) = '' then
        begin
           MessageDlg('Digite o Cidade',mtinformation, [mbOK], 0);
           valido := false;
           edtCidade.SetFocus;
        end;

        if trim( cboEstado.Text ) = '' then
        begin
           MessageDlg('Digite o Estado',mtinformation, [mbOK], 0);
           valido := false;
           cboEstado.SetFocus;
        end;

        if valido then
        begin
          sql := 'insert into cliente( nome, cpf, telefone, endereco, numero, cidade, estado, email )values(';
          sql := sql + '"' + edtNome.Text + '", "' + maskCpf.Text + '", "' + maskTelefone.Text + '",';
          sql := sql + '"' + edtEndereco.Text + '", "' + maskNumero.Text + '", "' + edtCidade.Text + '", "' + cboEstado.Text + '", "' + edtEmail.Text + '" )';

          ADOCommand.CommandText := sql;
          ADOCommand.Execute;

          MessageDlg('Cliente incluido com sucesso.',mtinformation, [mbOK], 0);

          edtNome.Text := '';
          maskCpf.Text := '';
          maskTelefone.Text := '';
          edtEndereco.Text := '';
          edtCidade.Text := '';
          cboEstado.Text := '';
          maskNumero.Text := '';
          edtEmail.Text := '';          
        end;
    end;
  finally
    ADODataSetConfirm.Active := false;
  end;
end;

procedure TfrmIncluirCliente.btSairClick(Sender: TObject);
begin
  frmClientes.ADODataSetGrid.Active := false;
  frmClientes.ADODataSetGrid.CommandText := 'select top 100 id, cpf, nome from cliente order by id desc';
  frmClientes.ADODataSetGrid.Active := true;
  frmClientes.edtNomeCpf.SetFocus;
  Close;
end;

procedure TfrmIncluirCliente.FormActivate(Sender: TObject);
begin
  edtNome.Text := '';
  maskCpf.Text := '';
  maskTelefone.Text := '';
  edtEndereco.Text := '';
  edtCidade.Text := '';
  cboEstado.Text := '';
  maskNumero.Text := '';
end;

end.
