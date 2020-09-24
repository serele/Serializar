using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Xml.Serialization;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;
using System.Net;

namespace Serializar
{
    public class Alumno
    {
        public string nombre;
        public string localidad;
    }

    class Program
    {
        static void Main(string[] args)
        {
            string xmlFileName = "serializado.xml";
            string txtFileName = "texto.txt";
            
            String xsltFileName = "..\\..\\myStyleSheet.xslt";

            Alumno alumno = new Alumno();

            Console.Write("Nombre: ");            
            alumno.nombre = Console.ReadLine();

            Console.Write("Localidad: ");
            alumno.localidad = Console.ReadLine();

            XmlSerializer serializer = new XmlSerializer(typeof(Alumno));

            TextWriter xmlWriter = new StreamWriter(xmlFileName);

            serializer.Serialize(xmlWriter, alumno);

            xmlWriter.Close();


            // aplicar XSLT            
            applyXSLT(xmlFileName, xsltFileName, txtFileName);
        }

        private static void applyXSLT(string xmlFileName, string xsltFileName, string txtFileName)
        {
            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load(xsltFileName);
            XPathDocument xpathdocument = new XPathDocument(xmlFileName);

            TextWriter txtWriter = new StreamWriter(txtFileName);
            XmlTextWriter writer = new XmlTextWriter(txtWriter);
            writer.Formatting = Formatting.Indented;

            xslt.Transform(xpathdocument, null, writer, null);            

            txtWriter.Close();            
            writer.Close();            
        }
        

        //private static void xmlTotxt(string xmlFileName, string txtFileName)
        //{
        //    System.Xml.Serialization.XmlSerializer reader =
        //    new System.Xml.Serialization.XmlSerializer(typeof(Alumno));
        //    System.IO.StreamReader file = new System.IO.StreamReader(xmlFileName);
        //    Alumno overview = (Alumno)reader.Deserialize(file);
        //    file.Close();
           
        //    TextWriter txtWriter = new StreamWriter(txtFileName);            
        //    txtWriter.WriteLine(overview.localidad);
        //    txtWriter.Close();            
        //}
    }
}
