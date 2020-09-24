<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>
  <xsl:variable name="CodigoCentro" select="//IdentificacionCert/CodigoCentro" />
  <xsl:variable name="CursoEscolar" select="//IdentificacionCert/CursoEscolar" />
  <xsl:variable name="FechaEnvio">
    <xsl:call-template name="FechaEnvioAncho8">
      <xsl:with-param name="fecha" select="//IdentificacionCert/FechaGeneracion" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:template match="/">
    <xsl:call-template name="Alumnos"/>
  </xsl:template>
  <xsl:template name="Alumnos">
    <xsl:for-each select="//Alumno">
      <xsl:call-template name="Alumno" />
      <xsl:if test ="position() != last()">
        <!--<xsl:text>&#xA;</xsl:text>-->
        <xsl:text>&#xD;&#xA;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name ="Alumno" match="Alumno">
    <xsl:apply-templates select="Matriculas"/>
  </xsl:template>
  <xsl:template match="Matriculas">
    <xsl:apply-templates select="Matricula"/>
  </xsl:template>
  <xsl:template match="Matricula">
    <!-- Código centro Pos.: 1-8 ; Lon.: 8-->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:value-of select="$CodigoCentro" disable-output-escaping="yes"/>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="8" />
    </xsl:call-template>

    <!-- Curso escolar Pos.: 9-12 ; Lon.: 4-->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:value-of select="$CursoEscolar" disable-output-escaping="yes"/>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="4" />
    </xsl:call-template>

    <!-- Fecha de envio Pos.: 13-20 ; Lon.: 8-->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:value-of select="$FechaEnvio" disable-output-escaping="yes"/>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="8" />
    </xsl:call-template>

    <!-- Código enseñanza Pos.: 21-23 ; Lon.: 3 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="CodEnsenyanza" />
      <xsl:with-param name ="ancho" select="3" />
    </xsl:call-template>

    <!-- Código estudio. Pos.: 24-28 ; Lon.: 5 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="CodEstudio" />
      <xsl:with-param name ="ancho" select="5" />
    </xsl:call-template>

    <!-- CIAL Pos.: 29-38 ; Lon.: 10 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../CIAL" />
      <xsl:with-param name ="ancho" select="10" />
    </xsl:call-template>

    <!-- Código Nacionalidad Pos.: 39-41 ; Lon.: 3 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../CodNacionalidad" />
      <xsl:with-param name ="ancho" select="3" />
    </xsl:call-template>

    <!-- Espacio en blanco. Pos.: 42-42 ; Lon.: 1 -->
    <xsl:call-template name="RellenoEspacio">
      <xsl:with-param name="num" select="1" />
    </xsl:call-template>

    <!-- NIFNIE Pos.: 43-51 ; Lon.: 9 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../NIFNIE" />
      <xsl:with-param name ="ancho" select="9" />
    </xsl:call-template>

    <!-- Pasaporte Pos.: 52-65 ; Lon.: 14 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Pasaporte" />
      <xsl:with-param name ="ancho" select="14" />
    </xsl:call-template>

    <!-- Repite Pos.: 66-66 ; Lon.: 1 -->
    <xsl:choose>
      <xsl:when test="Repite = 'true'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

    <!-- Nombre alumno Pos.: 67-96 ; Lon.: 30 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Nombre" />
      <xsl:with-param name ="ancho" select="30" />
    </xsl:call-template>

    <!-- Primer apellido alumno Pos.: 97-126 ; Lon.: 30 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Apellido1" />
      <xsl:with-param name ="ancho" select="30" />
    </xsl:call-template>

    <!-- Segundo apellido alumno Pos.: 127-156 ; Lon.: 30 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Apellido2" />
      <xsl:with-param name ="ancho" select="30" />
    </xsl:call-template>

    <!-- Código sexo alumno Pos.: 157-157 ; Lon.: 1 -->
    <xsl:value-of select="../../CodSexo" disable-output-escaping="yes"/>

    <!-- Número seguridad social alumno Pos.: 158-170 ; Lon.: 13 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../NumSeguridadSocial" />
      <xsl:with-param name ="ancho" select="13" />
    </xsl:call-template>

    <!-- Fecha de nacimiento alumno Pos.: 171-178 ; Lon.: 8 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:call-template name="FechaAncho8">
          <xsl:with-param name="fecha" select="../../FechaNacimiento"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="8" />
    </xsl:call-template>

    <!-- Código municipio alumno Pos.: 179-183 ; Lon.: 5 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../CodMunicipioNacimiento" />
      <xsl:with-param name ="ancho" select="5" />
    </xsl:call-template>

    <!-- Denominación municipio nacimiento alumno Pos.: 184-223 ; Lon.: 40 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../MunicipioProvinciaNacimiento" />
      <xsl:with-param name ="ancho" select="40" />
    </xsl:call-template>

    <!-- Código isla nacimiento alumno Pos.: 224-224 ; Lon.: 1 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../CodIslaNacimiento" />
      <xsl:with-param name ="ancho" select="1" />
    </xsl:call-template>

    <!-- Código provincia nacimiento alumno Pos.: 225-226 ; Lon.: 2 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../CodProvinciaNacimiento" />
      <xsl:with-param name ="ancho" select="2" />
    </xsl:call-template>

    <!-- Código pais nacimiento alumno Pos.: 227-229 ; Lon.: 3 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../CodPaisNacimiento" />
      <xsl:with-param name ="ancho" select="3" />
    </xsl:call-template>

    <!-- Genera la sección 1 de los tutores del alumno -->
    <xsl:call-template name="GenerarSeccion1Tutor" />

    <!-- Teléfono casa Pos.: 456-464 Lon.: 9 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../TfnoCasa" />
      <xsl:with-param name ="ancho" select="9" />
    </xsl:call-template>

    <!-- Genera la sección 2 de los tutores del alumno ; Tfno tutor1 y tutor2.-->
    <xsl:call-template name="GenerarSeccion2Tutor" />

    <!-- Tfno familiar Pos.: 483-491 Lon.: 9 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Tfnofamiliar" />
      <xsl:with-param name ="ancho" select="9" />
    </xsl:call-template>

    <!-- Tfno familiar movil Pos.: 492-500 Lon.: 9-->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../TfnofamiliarMovil" />
      <xsl:with-param name ="ancho" select="9" />
    </xsl:call-template>

    <!-- Genera la sección de la dirección del alumno -->
    <xsl:call-template name="GenerarSeccionDireccion" />

    <!-- Número de matrícula Pos.: 710-713 Lon.: 4 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="NumeroMatricula" />
      <xsl:with-param name ="ancho" select="4" />
    </xsl:call-template>

    <!-- Fecha de matrícula Pos.: 714-721 Lon.: 8-->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:call-template name="FechaAncho8">
          <xsl:with-param name="fecha" select="FechaMatricula" />
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="8" />
    </xsl:call-template>

    <!-- Fecha de baja Pos.: 722-729 Lon.: 8 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:call-template name="FechaAncho8">
          <xsl:with-param name="fecha" select="FechaBaja" />
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="8" />
    </xsl:call-template>

    <!-- Código de turno Pos.: 730-730  Lon.: 1 -->
    <xsl:value-of select="CodTurno" disable-output-escaping="yes"/>

    <!-- 4 espacios en blanco. Pos.: 731-734 Lon.: 4 -->
    <xsl:call-template name="RellenoEspacio">
      <xsl:with-param name="num" select="4" />
    </xsl:call-template>

    <!-- Serie libro Pos.: 735-738 Lon.: 4 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="SerieLibro" />
      <xsl:with-param name ="ancho" select="4" />
    </xsl:call-template>

    <!-- Número libro Pos.: 739-747 Lon.: 9 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="NumeroLibro" />
      <xsl:with-param name ="ancho" select="9" />
    </xsl:call-template>

    <!-- Acogida temprana Pos.: 748-748 Lon.: 1 -->
    <xsl:choose>
      <xsl:when test ="AcogidaTemprana = 'true'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

    <!-- Apoyo educativo Pos.: 749-749 Lon.: 1 -->
    <xsl:choose>
      <xsl:when test ="ApoyoEducativo = 'true'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

    <!-- 14 espacio en blanco Pos.: 750-763 Lon.: 14 -->
    <xsl:call-template name="RellenoEspacio">
      <xsl:with-param name="num" select="14" />
    </xsl:call-template>

    <!-- Observación Pos.: 764-863 Lon.: 100 -->
    <xsl:call-template name="RellenoEspacio">
      <xsl:with-param name="num" select="100" />
    </xsl:call-template>
    <!--<xsl:call-template name="RellenarEspaciosDerecha" >
        <xsl:with-param name="cadena" select="normalize-space(translate(../../Observacion, '&#xD;&#xA;', ' '))" />
        <xsl:with-param name ="ancho" select="100" />
      </xsl:call-template>-->

    <!-- 1 espacio en blanco. Pos.: 864-864 Lon.: 1  -->
    <xsl:call-template name="RellenoEspacio">
      <xsl:with-param name="num" select="1" />
    </xsl:call-template>

    <!-- Registro Pos.: 865-870 Lon.: 6 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Registro" />
      <xsl:with-param name ="ancho" select="6" />
    </xsl:call-template>

    <!-- ¿ Es matrícula viva ? Pos.: 871-871 Lon.: 1 -->
    <xsl:choose>
      <xsl:when test ="EsMatriculaViva = 'true'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

    <!-- ¿ Emancipado ? Pos.: 872-872 Lon.: 1 -->
    <xsl:choose>
      <xsl:when test ="../../Emancipado = 'true'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

    <!-- Genera sección 3 tutor -->
    <xsl:call-template name="GenerarSeccion3Tutor"/>

    <xsl:if test ="position() != last()">
      <!--<xsl:text>&#xA;</xsl:text>-->
      <xsl:text>&#xD;&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template name="GenerarSeccion1Tutor">
    <xsl:variable name="totalTutores" select="count(../../Tutores/Tutor)" />
    <xsl:choose>
      <xsl:when test="$totalTutores = 0">
        <xsl:call-template name="RellenoEspacio">
          <xsl:with-param name="num" select="226" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$totalTutores = 1">
        <xsl:call-template name="DatosSeccion1Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[1]" />
        </xsl:call-template>
        <xsl:call-template name="RellenoEspacio">
          <xsl:with-param name="num" select="113" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="DatosSeccion1Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[1]" />
        </xsl:call-template>
        <xsl:call-template name="DatosSeccion1Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[2]" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="DatosSeccion1Tutor">
    <xsl:param name="tutor" />
    <!-- NIFNIE tutor Tuto1(Pos.: 230-238 ; Lon.: 9) Tuto2(Pos.: 313-342 ; Lon.: 9)-->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="$tutor/NifNie" />
      <xsl:with-param name ="ancho" select="9" />
    </xsl:call-template>

    <!-- Pasaporte tutor Tutor1(Pos.: 239-252 ; Lon.: 14) Tutor2(Pos.: 352-365 ; Lon.: 14) -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="$tutor/Pasaporte" />
      <xsl:with-param name ="ancho" select="14" />
    </xsl:call-template>

    <!-- Nombre tutor Tutor1(Pos.: 253-282 ; Lon.: 30) Tutor2(Pos.: 366-395 ; Lon.: 30) -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="$tutor/Nombre" />
      <xsl:with-param name ="ancho" select="30" />
    </xsl:call-template>

    <!-- Primer apellido tutor Tutor1(Pos.: 283-312 ; Lon.: 30) Tutor2(Pos.: 396-425 ; Lon.: 30) -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="$tutor/Apellido1" />
      <xsl:with-param name ="ancho" select="30" />
    </xsl:call-template>

    <!-- Segundo apellido tutor Tutor1(Pos.: ; 313-342 Lon.: 30) Tutor2(Pos.: 426-455 ; Lon.: 30) -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="$tutor/Apellido2" />
      <xsl:with-param name ="ancho" select="30" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="GenerarSeccion2Tutor">
    <xsl:variable name="totalTutores" select="count(../../Tutores/Tutor)" />
    <xsl:choose>
      <xsl:when test="$totalTutores = 0">
        <xsl:call-template name="RellenoEspacio">
          <xsl:with-param name="num" select="18" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$totalTutores = 1">
        <xsl:call-template name="DatosSeccion2Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[1]" />
        </xsl:call-template>
        <xsl:call-template name="RellenoEspacio">
          <xsl:with-param name="num" select="9" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="DatosSeccion2Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[1]" />
        </xsl:call-template>
        <xsl:call-template name="DatosSeccion2Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[2]" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="DatosSeccion2Tutor">
    <xsl:param name="tutor" />
    <!-- Tfno trabajo tutor Tutor1(Pos.: 465-473 ; Lon.: 9) Tutor2(Pos.: 474-482 ; Lon.: 9)-->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="$tutor/TfnoTrabajo" />
      <xsl:with-param name ="ancho" select="9" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="GenerarSeccion3Tutor">
    <xsl:variable name="totalTutores" select="count(../../Tutores/Tutor)" />
    <xsl:choose>
      <xsl:when test="$totalTutores = 0">
        <xsl:call-template name="RellenoEspacio">
          <xsl:with-param name="num" select="24" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$totalTutores = 1">
        <xsl:call-template name="DatosSeccion3Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[1]" />
        </xsl:call-template>
        <xsl:call-template name="RellenoEspacio">
          <xsl:with-param name="num" select="12" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="DatosSeccion3Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[1]" />
        </xsl:call-template>
        <xsl:call-template name="DatosSeccion3Tutor">
          <xsl:with-param name="tutor" select="../../Tutores/Tutor[2]" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="DatosSeccion3Tutor">
    <xsl:param name="tutor" />
    <!-- ¿ Tiene patria potestad ? Tutor1(Pos.: 873-873 Lon.: 1) Tutor2(Pos.: 885-885 Lon.: 1) -->
    <xsl:choose>
      <xsl:when test ="$tutor/PatriaPotestad = 'true'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

    <!-- ¿ Tiene guada custodia ? Tutor1(Pos.: 874-874 Lon.: 1) Tutor2(Pos.: 886-886 Lon.: 1)-->
    <xsl:choose>
      <xsl:when test ="$tutor/GuardaCustodia = 'true'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

    <!-- Código sexo Tutor1(Pos.: 875-875 Lon.: 1) Tutor2(Pos.: 887-887 Lon.: 1)-->
    <xsl:value-of select="$tutor/CodSexo" disable-output-escaping="yes"/>

    <!-- Fecha de nacimiento Tutor1(Pos.: 876-883 Lon.: 8) Tutor2(Pos.: 888-895 Lon.: 8) -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:call-template name="FechaAncho8">
          <xsl:with-param name="fecha" select="$tutor/FechaNacimiento" />
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="8" />
    </xsl:call-template>

    <!-- Tipo vínculo del responsable Tutor1(Pos.: 884-884 Lon.: 1) Tutor2(Pos.:896-896 Lon.: 1) -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="$tutor/VinculoResponsable" />
      <xsl:with-param name ="ancho" select="1" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name ="GenerarSeccionDireccion">

    <!-- Código tipo vía Pos.: 501-502 Lon.: 2 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/CodTipoVia" />
      <xsl:with-param name ="ancho" select="2" />
    </xsl:call-template>

    <!-- Domicilio Pos.: 503-602 Lon.: 100 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Domicilio" />
      <xsl:with-param name ="ancho" select="100" />
    </xsl:call-template>

    <!-- Número Pos.: 603-609 Lon.: 7 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Numero" />
      <xsl:with-param name ="ancho" select="7" />
    </xsl:call-template>

    <!-- Bloque Pos.: 610-616 Lon.: 7 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Bloque" />
      <xsl:with-param name ="ancho" select="7" />
    </xsl:call-template>

    <!-- Portal Pos.: 617-623 Lon.: 7 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Portal" />
      <xsl:with-param name ="ancho" select="7" />
    </xsl:call-template>

    <!-- Letra Pos.: 624-630 Lon.: 7  -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Letra" />
      <xsl:with-param name ="ancho" select="7" />
    </xsl:call-template>

    <!-- Escalera Pos.: 631-637 Lon.: 7  -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Escalera" />
      <xsl:with-param name ="ancho" select="7" />
    </xsl:call-template>

    <!-- Piso Pos.: 5638-639 Lon.: 2 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Piso" />
      <xsl:with-param name ="ancho" select="2" />
    </xsl:call-template>

    <!-- Puerta Pos.: 640-646 Lon.: 7 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Puerta" />
      <xsl:with-param name ="ancho" select="7" />
    </xsl:call-template>

    <!-- Localidad Pos.: 647-696 Lon.: 50 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/Localidad" />
      <xsl:with-param name ="ancho" select="50" />
    </xsl:call-template>

    <!-- Código Municipio Pos.: 697-701 Lon.: 5 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/CodMunicipio" />
      <xsl:with-param name ="ancho" select="5" />
    </xsl:call-template>

    <!-- Código Isla Pos.: 702-702 Lon.: 1 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/CodIsla" />
      <xsl:with-param name ="ancho" select="1" />
    </xsl:call-template>

    <!-- Código postal Pos.: 703-707 Lon.: 5 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/CodPostal" />
      <xsl:with-param name ="ancho" select="5" />
    </xsl:call-template>

    <!-- Código provincia Pos.: 708-709 Lon.: 2 -->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena" select="../../Direccion/CodProvincia" />
      <xsl:with-param name ="ancho" select="2" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name ="RellenarEspaciosDerecha">
    <xsl:param name="cadena" />
    <xsl:param name="ancho" />
    <xsl:value-of select="substring($cadena, 1, $ancho)" disable-output-escaping="yes"/>
    <xsl:call-template name="RellenoEspacio">
      <xsl:with-param name ="num" select="$ancho - string-length($cadena)" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name ="RellenoEspacio">
    <xsl:param name="num"/>
    <xsl:if test ="$num  &gt; 0">
      <xsl:text> </xsl:text>
      <xsl:call-template name="RellenoEspacio">
        <xsl:with-param name="num" select="$num - 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name ="FechaAncho8">
    <xsl:param name="fecha" />
    <xsl:choose>
      <xsl:when test="$fecha != ''">
        <xsl:value-of select="concat(substring($fecha, 1, 2), substring($fecha, 4, 2), substring($fecha, 7, 4))" disable-output-escaping="yes"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="RellenoEspacio">
          <xsl:with-param name="num" select="8" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name ="FechaEnvioAncho8">
    <xsl:param name="fecha" />
    <xsl:value-of select="concat(substring($fecha, 9, 2), substring($fecha, 6, 2), substring($fecha, 1, 4))" disable-output-escaping="yes"/>
  </xsl:template>
</xsl:stylesheet>