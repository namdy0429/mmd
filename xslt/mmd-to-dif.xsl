<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dif="http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/"
  xmlns:mmd="http://www.met.no/schema/mmd"
  xmlns:dc="http://purl.org/dc/elements/1.1/" version="1.0"
  exclude-result-prefixes="mmd">

  <xsl:output method="xml" encoding="UTF-8" indent="yes" />

  <xs:sequence xmlns:xs="http://www.w3.org/2001/XMLSchema">
      <xs:element ref="Entry_ID" minOccurs="1" maxOccurs="1"/>
      <xs:element ref="Entry_Title" minOccurs="1" maxOccurs="1"/>
      <xs:element ref="Data_Set_Citation" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Personnel" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Discipline" minOccurs="0" maxOccurs="unbounded"/>
      <xs:element ref="Parameters" minOccurs="1" maxOccurs="unbounded"/>
      <xs:element ref="ISO_Topic_Category" minOccurs="0" maxOccurs="unbounded"/>
      <xs:element ref="Keyword" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Sensor_Name" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Source_Name" minOccurs="0" maxOccurs="unbounded"/>
      <xs:element ref="Temporal_Coverage" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Paleo_Temporal_Coverage" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Data_Set_Progress" minOccurs="0" maxOccurs="1"/>
      <xs:element ref="Spatial_Coverage" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Location" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Data_Resolution" minOccurs="0" maxOccurs="unbounded"/>
      <xs:element ref="Project" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Quality" minOccurs="0" maxOccurs="1"/>
      <xs:element ref="Access_Constraints" minOccurs="0" maxOccurs="1"/>
      <xs:element ref="Use_Constraints" minOccurs="0" maxOccurs="1"/>
      <xs:element ref="Data_Set_Language" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Originating_Center" minOccurs="0" maxOccurs="1"/>

      <xs:element ref="Data_Center" minOccurs="1" maxOccurs="unbounded"/>
    <xs:element ref="Distribution" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Multimedia_Sample" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Reference" minOccurs="0" maxOccurs="unbounded"/>
      <xs:element ref="Summary" minOccurs="1" maxOccurs="1"/>
      <xs:element ref="Related_URL" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Parent_DIF" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="IDN_Node" minOccurs="0" maxOccurs="unbounded"/>
    <xs:element ref="Originating_Metadata_Node" minOccurs="0" maxOccurs="1"/>
      <xs:element ref="Metadata_Name" minOccurs="1" maxOccurs="1"/>
      <xs:element ref="Metadata_Version" minOccurs="1" maxOccurs="1"/>
    <xs:element ref="DIF_Creation_Date" minOccurs="0" maxOccurs="1"/>
    <xs:element ref="Last_DIF_Revision_Date" minOccurs="0" maxOccurs="1"/>
    <xs:element ref="DIF_Revision_History" minOccurs="0" maxOccurs="1"/>
    <xs:element ref="Future_DIF_Review_Date" minOccurs="0" maxOccurs="1"/>
    <xs:element ref="Private" minOccurs="0" maxOccurs="1"/>
    <xs:element ref="Extended_Metadata" minOccurs="0" maxOccurs="unbounded"/>
  </xs:sequence>

  <xsl:template match="/mmd:mmd">
    <xsl:element name="dif:DIF">
      <xsl:apply-templates select="mmd:metadata_identifier" /> <!--Entry_ID-->
      <xsl:apply-templates select="mmd:title[1]" /> <!--Entry_Title-->
      <xsl:apply-templates select="mmd:dataset_citation" />
      <xsl:apply-templates select="mmd:keywords[@vocabulary='gcmd']"/>
      <xsl:apply-templates select="mmd:iso_topic_category" />
      <xsl:apply-templates select="mmd:keywords[@vocabulary='none']"/>
      <xsl:apply-templates select="mmd:temporal_extent" /> <!--Temporal_Coverage-->
      <xsl:apply-templates select="mmd:dataset_production_status" /> <!--Data_Set_Progress-->
      <xsl:apply-templates select="mmd:geographic_extent/mmd:rectangle" /> <!--Spatial_Coverage-->
      <xsl:apply-templates select="mmd:project" />
      <xsl:apply-templates select="mmd:access_constraint" />
      <xsl:apply-templates select="mmd:use_constraint" />
      <xsl:apply-templates select="mmd:dataset_language" />
      <xsl:apply-templates select="mmd:data_center" />
      <xsl:apply-templates select="mmd:abstract[@xml:lang = 'en']" /> <!--Summary-->
      <xsl:apply-templates select="mmd:data_access" /> <!--Related_URL-->
      <dif:Metadata_Name>CEOS IDN DIF</dif:Metadata_Name>
      <dif:Metadata_Version>9.7 </dif:Metadata_Version> <!--this should rather be 9.8.2-->
      <xsl:apply-templates select="mmd:last_metadata_update" /> <!--Last_DIF_Revision_Date-->

      <!--The following are not generating legal DIF-->
      <!--<xsl:apply-templates select="mmd:instrument" />-->
      <!--<xsl:apply-templates select="mmd:platform" />-->
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:metadata_identifier">
    <xsl:element name="dif:Entry_ID">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:title">
    <xsl:element name="dif:Entry_Title">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:abstract">
    <xsl:element name="dif:Summary">
      <xsl:element name="dif:Abstract">
        <xsl:value-of select="." />
      </xsl:element>
      <xsl:element name="dif:Purpose" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:last_metadata_update">
    <xsl:element name="dif:Last_DIF_Revision_Date">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:keywords[@vocabulary='gcmd']">
    <xsl:variable name="topic" select="substring-before(., ' &gt; ')"/>
    <xsl:variable name="after" select="substring-after(., concat($topic, ' &gt; ') )"/>
    <xsl:variable name="term"  select="substring-before($after, ' &gt; ')"/>
    <xsl:variable name="var1"  select="substring-after($after, ' &gt; ')"/>
    <dif:Parameters>
      <dif:Category>EARTH SCIENCE</dif:Category>
      <dif:Topic><xsl:value-of select="$topic"/></dif:Topic>
      <dif:Term><xsl:value-of select="$term"/></dif:Term>
      <dif:Variable_Level_1><xsl:value-of select="$var1"/></dif:Variable_Level_1>
      <dif:Detailed_Variable><xsl:value-of select="'Not Available'"/></dif:Detailed_Variable>
    </dif:Parameters>
  </xsl:template>

  <xsl:template match="mmd:keywords[@vocabulary='none']">
    <xsl:for-each select="mmd:keyword">
      <xsl:element name="dif:Keyword">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="mmd:temporal_extent">
    <xsl:element name="dif:Temporal_Coverage">
      <xsl:element name="dif:Start_Date">
        <xsl:value-of select="mmd:start_date" />
      </xsl:element>
      <xsl:element name="dif:Stop_Date">
        <xsl:value-of select="mmd:end_date" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:geographic_extent/mmd:rectangle">
    <xsl:element name="dif:Spatial_Coverage">
      <xsl:element name="dif:Southernmost_Latitude">
        <xsl:value-of select="mmd:south" />
      </xsl:element>
      <xsl:element name="dif:Northernmost_Latitude">
        <xsl:value-of select="mmd:north" />
      </xsl:element>
      <xsl:element name="dif:Westernmost_Longitude">
        <xsl:value-of select="mmd:west" />
      </xsl:element>
      <xsl:element name="dif:Easternmost_Longitude">
        <xsl:value-of select="mmd:east" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:data_access">
    <xsl:element name="dif:Related_URL">
      <xsl:element name="dif:URL_Content_Type">
        <xsl:element name="dif:Type">
          <xsl:value-of select="mmd:type" />
        </xsl:element>
      </xsl:element>
      <xsl:element name="dif:URL">
        <xsl:value-of select="mmd:resource" />
      </xsl:element>
      <xsl:element name="dif:Description">
        <xsl:value-of select="mmd:description" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:project">
    <xsl:element name="dif:Project">
      <xsl:element name="dif:Short_Name">
        <xsl:value-of select="mmd:short_name" />
      </xsl:element>
      <xsl:element name="dif:Long_Name">
        <xsl:value-of select="mmd:long_name" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:instrument">
    <xsl:element name="dif:Instrument">
      <xsl:element name="dif:Short_Name">
        <xsl:value-of select="mmd:short_name" />
      </xsl:element>
      <xsl:element name="dif:Long_Name">
        <xsl:value-of select="mmd:long_name" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:platform">
    <xsl:element name="dif:Platform"> <!--Not a legal DIF element! -->
      <xsl:element name="dif:Short_Name">
        <xsl:value-of select="mmd:short_name" />
      </xsl:element>
      <xsl:element name="dif:Long_Name">
        <xsl:value-of select="mmd:long_name" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:access_constraint">
    <xsl:element name="dif:Access_Constraints">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:use_constraint">
    <xsl:element name="dif:Use_Constraints">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:dataset_production_status">
    <xsl:element name="dif:Data_Set_Progress">
      TODO: Fix proper translation of status
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:dataset_language">
    <xsl:element name="dif:Data_Set_Language">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:iso_topic_category">
    <xsl:element name="dif:ISO_Topic_Category">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mmd:data_center">
    <xsl:element name="dif:Data_Center">
      <xsl:element name="dif:Data_Center_Name">
        <xsl:element name="dif:Short_Name">
          <xsl:value-of select="mmd:data_center_name/mmd:short_name" />
        </xsl:element>
        <xsl:element name="dif:Long_Name">
          <xsl:value-of select="mmd:data_center_name/mmd:long_name" />
        </xsl:element>
      </xsl:element>
      <xsl:element name="dif:Data_Center_URL">
        <xsl:value-of select="mmd:data_center_url" />
      </xsl:element>
      <xsl:element name="dif:Data_Set_ID">
        <xsl:value-of select="mmd:dataset_id" />
      </xsl:element>
      <xsl:element name="dif:Personnel">
        <xsl:element name="dif:Role">
          <xsl:value-of select="mmd:personnel/mmd:role"></xsl:value-of>
        </xsl:element>
        <xsl:element name="dif:First_Name" />
        <xsl:element name="dif:Middle_Name" />
        <xsl:element name="dif:Last_Name">
          <xsl:value-of select="mmd:personnel/mmd:name"></xsl:value-of>
        </xsl:element>
        <xsl:element name="dif:Phone">
          <xsl:value-of select="mmd:personnel/mmd:phone"></xsl:value-of>
        </xsl:element>
        <xsl:element name="dif:Fax">
          <xsl:value-of select="mmd:personnel/mmd:fax"></xsl:value-of>
        </xsl:element>

        <xsl:element name="dif:Contact_Address">
          <xsl:element name="dif:Address">
            <xsl:value-of select="mmd:personnel/mmd:contact_address/mmd:address" />
          </xsl:element>
          <xsl:element name="dif:City">
            <xsl:value-of select="mmd:personnel/mmd:contact_address/mmd:city" />
          </xsl:element>
          <xsl:element name="dif:Province_or_State">
            <xsl:value-of
              select="mmd:personnel/mmd:contact_address/mmd:province_or_state" />
          </xsl:element>
          <xsl:element name="dif:Postal_Code">
            <xsl:value-of select="mmd:personnel/mmd:contact_address/mmd:postal_code" />
          </xsl:element>
          <xsl:element name="dif:Country">
            <xsl:value-of select="mmd:personnel/mmd:contact_address/mmd:country" />
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>


  <xsl:template match="mmd:dataset_citation">
    <xsl:element name="dif:Data_Set_Citation">
      <xsl:element name="dif:Dataset_Creator">
        <xsl:value-of select="mmd:dataset_creator" />
      </xsl:element>
      <xsl:element name="dif:Dataset_Editor">
        <xsl:value-of select="mmd:dataset_editor" />
      </xsl:element>
      <xsl:element name="dif:Dataset_Title">
        <xsl:value-of select="mmd:dataset_title" />
      </xsl:element>
      <xsl:element name="dif:Dataset_Series_Name">
        <xsl:value-of select="mmd:dataset_series_name" />
      </xsl:element>
      <xsl:element name="dif:Dataset_Release_Date">
        <xsl:value-of select="mmd:dataset_release_date" />
      </xsl:element>
      <xsl:element name="dif:Dataset_Release_Place">
        <xsl:value-of select="mmd:dataset_release_place" />
      </xsl:element>
      <xsl:element name="dif:Dataset_Publisher">
        <xsl:value-of select="mmd:dataset_publisher" />
      </xsl:element>
      <xsl:element name="dif:Version">
        <xsl:value-of select="mmd:version" />
      </xsl:element>
      <xsl:element name="dif:Data_Presentation_Form">
        <xsl:value-of select="mmd:dataset_presentation_form" />
      </xsl:element>
      <xsl:element name="dif:Online_Resource">
        <xsl:value-of select="mmd:online_resource" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
