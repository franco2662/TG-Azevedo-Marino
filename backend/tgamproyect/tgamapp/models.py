# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Analisis(models.Model):
    id = models.AutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    nombrepc = models.TextField(db_column='NombrePc')  # Field name made lowercase.
    fecha = models.DateTimeField(db_column='Fecha')  # Field name made lowercase.
    fk_sesion = models.ForeignKey('Sesion',related_name='analisis_sesion', on_delete =models.DO_NOTHING, db_column='Fk_Sesion', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Analisis'


class Persona(models.Model):
    id = models.AutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    nombre = models.CharField(db_column='Nombre', max_length=100)  # Field name made lowercase.
    apellido = models.CharField(db_column='Apellido', max_length=100)  # Field name made lowercase.
    fechanac = models.DateField(db_column='FechaNac')  # Field name made lowercase.
    docidentidad = models.CharField(db_column='DocIdentidad', max_length=100)  # Field name made lowercase.
    sexo = models.CharField(db_column='Sexo', max_length=100)  # Field name made lowercase. This field type is a guess.

    class Meta:
        managed = False
        db_table = 'Persona'


class Proceso(models.Model):
    id = models.BigAutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    node = models.TextField(db_column='Node',  blank=True, null=True)  # Field name made lowercase.
    commandline = models.TextField(db_column='CommandLine',  blank=True, null=True)  # Field name made lowercase.
    csname = models.TextField(db_column='CSName',  blank=True, null=True)  # Field name made lowercase.
    description = models.TextField(db_column='Description',  blank=True, null=True)  # Field name made lowercase.
    executablepath = models.TextField(db_column='ExecutablePath',  blank=True, null=True)  # Field name made lowercase.
    executablestate = models.BigIntegerField(db_column='ExecutableState', blank=True, null=True)  # Field name made lowercase.
    handle = models.BigIntegerField(db_column='Handle', blank=True, null=True)  # Field name made lowercase.
    handlecount = models.BigIntegerField(db_column='HandleCount', blank=True, null=True)  # Field name made lowercase.
    kernelmodetime = models.BigIntegerField(db_column='KernelModeTime', blank=True, null=True)  # Field name made lowercase.
    maximumworkingsetsize = models.BigIntegerField(db_column='MaximumWorkingSetSize', blank=True, null=True)  # Field name made lowercase.
    minimumworkingsetsize = models.BigIntegerField(db_column='MinimumWorkingSetSize', blank=True, null=True)  # Field name made lowercase.
    osname = models.TextField(db_column='OSName',  blank=True, null=True)  # Field name made lowercase.
    otheroperationcount = models.BigIntegerField(db_column='OtherOperationCount', blank=True, null=True)  # Field name made lowercase.
    othertransfercount = models.BigIntegerField(db_column='OtherTransferCount', blank=True, null=True)  # Field name made lowercase.
    pagefaults = models.BigIntegerField(db_column='PageFaults', blank=True, null=True)  # Field name made lowercase.
    pagefileusage = models.BigIntegerField(db_column='PageFileUsage', blank=True, null=True)  # Field name made lowercase.
    parentprocessid = models.BigIntegerField(db_column='ParentProcessId', blank=True, null=True)  # Field name made lowercase.
    peakpagefileusage = models.BigIntegerField(db_column='PeakPageFileUsage', blank=True, null=True)  # Field name made lowercase.
    peakvirtualsize = models.BigIntegerField(db_column='PeakVirtualSize', blank=True, null=True)  # Field name made lowercase.
    peakworkingsetsize = models.BigIntegerField(db_column='PeakWorkingSetSize', blank=True, null=True)  # Field name made lowercase.
    priority = models.BigIntegerField(db_column='Priority', blank=True, null=True)  # Field name made lowercase.
    privatepagecount = models.BigIntegerField(db_column='PrivatePageCount', blank=True, null=True)  # Field name made lowercase.
    processid = models.BigIntegerField(db_column='ProcessId', blank=True, null=True)  # Field name made lowercase.
    quotanonpagedpoolusage = models.BigIntegerField(db_column='QuotaNonPagedPoolUsage', blank=True, null=True)  # Field name made lowercase.
    quotapagedpoolusage = models.BigIntegerField(db_column='QuotaPagedPoolUsage', blank=True, null=True)  # Field name made lowercase.
    quotapeaknonpagedpoolusage = models.BigIntegerField(db_column='QuotaPeakNonPagedPoolUsage', blank=True, null=True)  # Field name made lowercase.
    quotapeakpagedpoolusage = models.BigIntegerField(db_column='QuotaPeakPagedPoolUsage', blank=True, null=True)  # Field name made lowercase.
    readoperationcount = models.BigIntegerField(db_column='ReadOperationCount', blank=True, null=True)  # Field name made lowercase.
    readtransfercount = models.BigIntegerField(db_column='ReadTransferCount', blank=True, null=True)  # Field name made lowercase.
    sessionid = models.BigIntegerField(db_column='SessionId', blank=True, null=True)  # Field name made lowercase.
    threadcount = models.BigIntegerField(db_column='ThreadCount', blank=True, null=True)  # Field name made lowercase.
    usermodetime = models.BigIntegerField(db_column='UserModeTime', blank=True, null=True)  # Field name made lowercase.
    virtualsize = models.BigIntegerField(db_column='VirtualSize', blank=True, null=True)  # Field name made lowercase.
    windowsversion = models.TextField(db_column='WindowsVersion',  blank=True, null=True)  # Field name made lowercase.
    workingsetsize = models.BigIntegerField(db_column='WorkingSetSize', blank=True, null=True)  # Field name made lowercase.
    writeoperationcount = models.BigIntegerField(db_column='WriteOperationCount', blank=True, null=True)  # Field name made lowercase.
    writetransfercount = models.BigIntegerField(db_column='WriteTransferCount', blank=True, null=True)  # Field name made lowercase.
    fk_analisis = models.ForeignKey('Analisis',related_name='proceso_analisis', on_delete =models.DO_NOTHING, db_column='Fk_Analisis', blank=True, null=True)  # Field name made lowercase.
    fk_tipo = models.ForeignKey('Tipo',related_name='proceso_tipo', on_delete =models.DO_NOTHING, db_column='Fk_Tipo', blank=True, null=True)  # Field name made lowercase.
    porcentaje_no =models.DecimalField(db_column='Porcentaje_No', blank=True, null=True, max_digits=5, decimal_places=2)  # Field name made lowercase.
    class Meta:
        managed = False
        db_table = 'Proceso'


class Registro(models.Model):
    id = models.BigAutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    nombre = models.TextField(db_column='Nombre')  # Field name made lowercase.
    fk_tipo = models.ForeignKey('Tipo',related_name='registro_tipo', on_delete =models.DO_NOTHING, db_column='Fk_Tipo', blank=True, null=True)  # Field name made lowercase.
    fk_analisis = models.ForeignKey('Analisis',related_name='registro_analisis', on_delete =models.DO_NOTHING, db_column='Fk_Analisis', blank=True, null=True)  # Field name made lowercase.
    porcentaje_no =models.DecimalField(db_column='Porcentaje_No', blank=True, null=True, max_digits=5, decimal_places=2)  # Field name made lowercase.
    class Meta:
        managed = False
        db_table = 'Registro'

class Directorio(models.Model):
    id = models.BigAutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    nombre = models.TextField(db_column='Nombre')  # Field name made lowercase.
    fk_tipo = models.ForeignKey('Tipo',related_name='directorio_tipo', on_delete =models.DO_NOTHING, db_column='Fk_Tipo', blank=True, null=True)  # Field name made lowercase.
    fk_analisis = models.ForeignKey('Analisis',related_name='directorio_analisis', on_delete =models.DO_NOTHING, db_column='Fk_Analisis', blank=True, null=True)  # Field name made lowercase.
    porcentaje_no =models.DecimalField(db_column='Porcentaje_No', blank=True, null=True, max_digits=5, decimal_places=2)  # Field name made lowercase.
    class Meta:
        managed = False
        db_table = 'Directorio'


class Rol(models.Model):
    id = models.AutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    nombre = models.CharField(db_column='Nombre', max_length=100)  # Field name made lowercase.
    descripcion = models.CharField(db_column='Descripcion', max_length=100, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Rol'


class Sesion(models.Model):
    id = models.AutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    horainicio = models.DateTimeField(db_column='HoraInicio')  # Field name made lowercase.
    #horafin = models.DateTimeField(db_column='HoraFin', blank=True, null=True)  # Field name made lowercase.
    ipconexion = models.CharField(db_column='IpConexion', max_length=15)  # Field name made lowercase.
    fk_usuario = models.ForeignKey('Usuario',related_name='usuario', on_delete =models.DO_NOTHING, db_column='Fk_Usuario')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Sesion'


class Tipo(models.Model):
    id = models.AutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    nombre = models.CharField(db_column='Nombre', max_length=100)  # Field name made lowercase.
    descripcion = models.CharField(db_column='Descripcion', max_length=100, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Tipo'

class Empresa(models.Model):
     id = models.AutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
     nombre = models.CharField(db_column='Nombre', max_length=100)  # Field name made lowercase. 

     class Meta:
        managed = False
        db_table = 'Empresa'
class Usuario(models.Model):
    id = models.AutoField(db_column='Id', primary_key=True)  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=100)  # Field name made lowercase.
    clave = models.CharField(db_column='Clave', max_length=100)  # Field name made lowercase.
    fechacreacion = models.DateTimeField(db_column='FechaCreacion')  # Field name made lowercase.
    fk_rol = models.ForeignKey(Rol, related_name='rol', on_delete =models.DO_NOTHING, db_column='Fk_Rol', blank=True, null=True)  # Field name made lowercase.
    fk_persona = models.ForeignKey(Persona, related_name='persona', on_delete =models.DO_NOTHING, db_column='Fk_Persona', blank=True, null=True)  # Field name made lowercase.
    estado = models.BooleanField(db_column='Estado', blank=True, null=True, default=True)  # Field name made lowercase.
    fk_empresa = models.ForeignKey(Empresa, related_name='empresa', on_delete =models.DO_NOTHING, db_column='Fk_Empresa', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Usuario'


class ViewUserList(models.Model):
    id = models.BigIntegerField(db_column='id',primary_key=True)  # Field name made lowercase.
    nombre_completo = models.CharField(db_column='nombre_completo', max_length=150)
    email = models.CharField(db_column='email', max_length=100)  # Field name made lowercase.
    doc_identidad = models.CharField(db_column='doc_identidad', max_length=100)  # Field name made lowercase.
    rol = models.CharField(db_column='rol', max_length=100)  # Field name made lowercase.
    empresa = models.CharField(db_column='empresa', max_length=100)  # Field name made lowercase.
    estado = models.BooleanField(db_column='estado', blank=True, null=True, default=True)  # Field name made lowercase.
    class Meta:
        managed = False
        db_table = 'vw_user_list'

class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class MyappTipo(models.Model):
    id = models.BigAutoField(primary_key=True)
    nombre = models.CharField(db_column='Nombre', max_length=100)  # Field name made lowercase.
    descripcion = models.CharField(db_column='Descripcion', max_length=100)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'myapp_tipo'
