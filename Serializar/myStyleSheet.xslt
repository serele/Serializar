<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>

  <xsl:variable name="Nombre" select="//Alumno/nombre" />
  <xsl:variable name="Localidad" select="//Alumno/localidad" />

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
  
  <xsl:template match="Alumno">

    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:value-of select="$Nombre"/>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="8" />
    </xsl:call-template>
    
    <!--<xsl:value-of select="Alumno/localidad" disable-output-escaping="yes"/>-->
    <xsl:call-template name="RellenarEspaciosDerecha" >
      <xsl:with-param name="cadena">
        <xsl:value-of select="$Localidad"/>
      </xsl:with-param>
      <xsl:with-param name ="ancho" select="8" />
    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>