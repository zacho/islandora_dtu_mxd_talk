<?php

/**
 * @file 
 * MXD Talk classes
 */
define("FEDORA_REPOSITORY_PATH",'/fedora/repository');

/**
 * MXDTalkManipulation
 */
class MXDTalkManipulation {

  /**
   * Constructor
   */
  function MXDTalkManipulation($pid = null) {
    module_load_include('inc', 'fedora_repository', 'ObjectHelper');
    $this->pid = $pid;
  }

  /**
   * Create SWF from PDF
   * @param type $parameterArray
   * @param type $dsid
   * @param type $file
   * @param type $file_ext
   * @return boolean
   */
  function createSWFFromPDF($parameterArray, $dsid, $file, $file_ext) {
    // command = pdf2swf infile.pdf -o outfile.swf -T 9 -f
    // there should be no reason this function would be supplied with a $file_ext other than 'swf'
    if (strcasecmp($file_ext,'swf')) {
        $file_ext = 'swf';
    }
    $outfile = $file . "." . $file_ext;
    $returnValue = true;
    $command = "pdf2swf \"$file\" -o \"$outfile\" -T 9 -f";
    system($command, $returnValue);
    if ($returnValue == '0') {
      $_SESSION['fedora_ingest_files']["$dsid"] = $outfile;
      return TRUE;
    }
    else {
      return $returnValue;
    }
  }

  /**
   * Create Thumbnail from PDF
   * @param type $parameterArray
   * @param type $dsid
   * @param type $file
   * @param type $file_ext
   * @return boolean 
   */
  function createThumbnailFromPDF($parameterArray, $dsid, $file, $file_ext) {
    $height = $parameterArray['height'];
    $width = $parameterArray['width'];
    $file_suffix = '_' . $dsid . '.' . $file_ext;
    $returnValue = TRUE;
    
    // If there's no PDF to convert, use the default thumbnail.
    if (!file_exists($file)) {
      $path = drupal_get_path('module','islandora_dtu_mxd_talk');
      $source_file = $path . "/images/mime.png";
      $dest_file = tempnam(sys_get_temp_dir(), 'mime') . ".png";
      copy($source_file,$dest_file);
      return $returnValue;
    }
    
    //system("convert $file\[0\] -thumbnail 128x128 $uploaddir$thumb");
    // Use this for Linux.
    if (stristr($_SERVER['SERVER_SOFTWARE'], 'microsoft')) {

    }
    elseif (stristr($_SERVER['SERVER_SOFTWARE'], 'linux')) {
      $cmdline = "/usr/local/bin/convert \"$file\"\[0\] -colorspace RGB -thumbnail $width" . "x$height \"$file$file_suffix\"";
    }
    elseif (stristr($_SERVER['SERVER_SOFTWARE'], 'unix')) {
      // Use this for Mac OS X (MAMP)
      $cmdline = "sips -s format jpeg \"$file\" -z $height $height --out \"$file$file_suffix\" >/dev/null";
    }
    else {
      $cmdline = "convert \"$file\"\[0\] -colorspace RGB -thumbnail " . $width . "x" . $height . " \"$file$file_suffix\"";
    }

    system($cmdline, $returnValue);
    //system("convert $file\[0\] -thumbnail 128x128 $uploaddir$thumb");
    $var = $file . $file_suffix . ' returnvalue= ' . $returnValue;

    if ($returnValue == '0') {
      $_SESSION['fedora_ingest_files']["$dsid"] = $file . $file_suffix;
      return TRUE;
    }
    else {
      return $returnValue;
    }
  }

}

/**
 * ShowMXDTalkStreams
 */
class ShowMXDTalkDatastreams {

  /**
   * Constructor
   */
  function ShowMXDTalkDatastreams($pid = null) {
    module_load_include('inc', 'fedora_repository', 'ObjectHelper');
    $this->pid = $pid;
  }


  /**
    * Embed PDF either directly using PDFObject or as an SWF using FlexPaper.
    * @global type $base_url
    * @global type $base_path
    * @global type $user
    * @return type 
    */
  function showTalkPreview() {
    global $base_url;
    global $base_path;
    global $user;
    drupal_add_css(drupal_get_path('module', 'islandora_dtu_mxd_talk') . '/css/mxd.css');
    module_load_include('inc', 'fedora_repository', 'api/fedora_item');
    
    $tabset = array();

    $tabset['first_tab'] = array(
      '#type' => 'tabpage',
      '#title' => t('Description'),
    );

    $tabset['first_tab']['tabs'] = array(
      '#type' => 'tabset',
    );
    $objectHelper = new TalkObjectHelper();
    $item = new Fedora_Item($this->pid);

    // Give the page a proper title using the object label.
    if ( !empty($item->objectProfile->objLabel)) {
      drupal_set_title(preg_replace_callback( '/\%u([0-9a-f]{4})/i', 'replace_unicode_escape_sequence', $item->objectProfile->objLabel));
    }

    if (key_exists('TN', $item->datastreams)) {
      $tn_url = $base_url . '/fedora/repository/' . $item->pid . '/TN';
    }
    else {
      $tn_url = $base_path . drupal_get_path('module', 'fedora_repository') . '/images/Crystal_Clear_app_download_manager.png';
    }
    $mxd_html = $objectHelper->getFormattedMXD($item);
    $object_html = $objectHelper->getFormattedDatastreams($item);

    $description_html = $mxd_html.$object_html;

    // $dl_link = l('<div  style="float:left; padding: 10px"><img src="' . $tn_url . '"><br />View Document</div>', 'fedora/repository/' . $this->pid . '/OBJ', array('html' => TRUE));

    $tabset['first_tab'] = array(
      '#type' => 'tabpage',
      '#title' => t('View'),
      '#content' => $description_html,
    );


    // Render the tabset.
    return $tabset;
  }

  /**
    * Don't do anything fancy either directly using PDFObject or as an SWF using FlexPaper.
    * @global type $base_url
    * @global type $base_path
    * @global type $user
    * @return type 
    */
  function showPDFPreview() {
    global $base_url;
    global $base_path;
    global $user;
    module_load_include('inc', 'fedora_repository', 'api/fedora_item');
    
    $tabset = array();

    $tabset['first_tab'] = array(
      '#type' => 'tabpage',
      '#title' => t('Description'),
    );

    $tabset['first_tab']['tabs'] = array(
      '#type' => 'tabset',
    );
    $objectHelper = new TalkObjectHelper();
    $item = new Fedora_Item($this->pid);

    // Give the page a proper title using the object label.
    if ( !empty($item->objectProfile->objLabel)) {
      drupal_set_title(preg_replace_callback( '/\%u([0-9a-f]{4})/i', 'replace_unicode_escape_sequence', $item->objectProfile->objLabel));
    }

    if (key_exists('TN', $item->datastreams)) {
      $tn_url = $base_url . '/fedora/repository/' . $item->pid . '/TN';
    }
    else {
      $tn_url = $base_path . drupal_get_path('module', 'fedora_repository') . '/images/Crystal_Clear_app_download_manager.png';
    }

    $dc_html = $objectHelper->getFormattedDC($item);

    $dl_link = l('<div  style="float:left; padding: 10px"><img src="' . $tn_url . '"><br />View Document</div>', 'fedora/repository/' . $this->pid . '/OBJ', array('html' => TRUE));

    $tabset['first_tab'] = array(
      '#type' => 'tabpage',
      '#title' => t('View'),
      '#content' => $dl_link . $dc_html,
    );


    // Render the tabset.
    return $tabset;
  }

}

/**
 * ObjectHelper Extension Class
 */
class TalkObjectHelper extends ObjectHelper {
    
  /**
   * Get Formatted Talk Datastreams
   * @global type $base_url
   * @param type $item
   * @return type 
   */
  function getFormattedDatastreams($item,$as_table_cells=false) {
  global $base_url;
    module_load_include('inc','fedora_repository','CollectionClass');
    $col_class = new CollectionClass($item->pid);
    $related_items = $col_class->getRelatedItems($item->pid);
    
    $hasPaper = key_exists('OBJ', $item->datastreams);
    $hasSlide = false;
    $hasVideo = false;

    $path = drupal_get_path('module','islandora_dtu_mxd_talk');
    $xslfile = ($as_table_cells ? '/xsl/convertSparqlTD.xsl' : '/xsl/convertSparql.xsl' );
    
    if (empty($related_items)) {
      return '';
    }
        
    try {
      $proc = new XsltProcessor();
    } catch (exception $e) {
      drupal_set_message($e->getMessage(),'error');
      return;
    }
  
    $xmlstr = $related_items;
    
    $proc->setParameter('','baseUrl',$base_url);
    $proc->setParameter('','renderPath',$base_url.'/islandora/dtu/renderpdf');
    $proc->setParameter('','pid',$item->pid);
    $label = preg_replace('/%u(\d\d+)/','',$item->objectProfile->objLabel);
    if (!empty($label)) {
      $proc->setParameter('','label',substr($label,0,65));
    } else {
      $proc->setParameter('','label','item');
    }
    $proc->setParameter('','path',$base_url.'/'.$path);
    if ($hasPaper) {
      $proc->setParameter('','paperObj',$base_url.'/fedora/repository/'.$item->pid.'/OBJ/paper.pdf');
    } else {
      $proc->setParameter('','paperObj','');
    }
    $proc->setParameter('','videoImg',$base_url.'/'.$path.'/images/video_32.png');
    $proc->setParameter('','slideImg',$base_url.'/'.$path.'/images/Crystal_Clear_mimetype_pdf_32.png');
    $proc->setParameter('','paperImg',$base_url.'/'.$path.'/images/Crystal_Clear_mimetype_document_32.png');
    
    $input = NULL;
    $xsl = new DomDocument();
    try {
      $xsl->load($path.$xslfile);
      $input = new DomDocument();
      $input->loadXML(trim($xmlstr));
    } catch (exception $e) {
      watchdog(t("fedora_repository"), "Problem loading XSL file: @e", array('@e' => $e), NULL, WATCHDOG_ERROR);
    }
    $xsl = $proc->importStylesheet($xsl);
    $newdom = $proc->transformToDoc($input);
    $output = $newdom->saveHTML();
    
    return $output;
  
  }


  /**
   * Get Formatted MXD
   * @global type $base_url
   * @param type $item
   * @return type 
   */
  function getFormattedMXD($item) {
    global $base_url;

    module_load_include('inc','fedora_repository','ConnectionHelper');

    if( array_key_exists('MXD', $item->get_datastreams_list_as_array()) ) {
      $dsid = 'MXD';
      $path = drupal_get_path('module','islandora_dtu_mxd_talk');
      $xslfile = '/xsl/convertMXD.xsl';
    } else {
      $dsid = 'DC';
      $path = drupal_get_path('module','fedora_repository');
      $xslfile = '/xsl/convertQDC.xsl';
    }
    $xmlstr = $item->get_datastream_dissemination($dsid);
    
    if (empty ($xmlstr)) {
      return '';
    }
    
    try {
      $proc = new XsltProcessor();
    } catch (exception $e) {
      drupal_set_message($e->getMessage(),'error');
      return;
    }
    
    $proc->setParameter('','baseUrl',$base_url);
    $proc->setParameter('','path',$base_url.'/'.$path);
    $input = NULL;
    $xsl = new DomDocument();
    try {
      $xsl->load($path.$xslfile);
      $input = new DomDocument();
      $input->loadXML(trim($xmlstr));
    } catch (exception $e) {
      watchdog(t("fedora_repository"), "Problem loading XSL file: @e", array('@e' => $e), NULL, WATCHDOG_ERROR);
    }
    $xsl = $proc->importStylesheet($xsl);
    $newdom = $proc->transformToDoc($input);
    $output = $newdom->saveHTML();
    return $output;
  }

  function ingest_secondary_fedora_objects(array &$form, array &$form_state, $parent_pid) {
  global $base_url;
  module_load_include('inc', 'islandora_content_model_forms', 'FOXML');
  module_load_include('inc', 'islandora', 'api/fedora_item');
  $path = drupal_get_path('module','islandora_dtu_mxd_talk');
  $parent_item = new Fedora_Item($parent_pid);
  $collection_pid = $parent_item->objectProfile->pid;
  $relationship = "isMemberOf";
  $state = 'A';  //$form['#post']['active-toggle'] ? 'A' : 'I';
  foreach ($form_state['values'] as $field=>$filename) {
    if (!strncmp('ingest-file-location-',$field,21) && !empty($filename)) {
      $DSID = substr($field,21);
      switch ($DSID) {
        case 'SLIDE':

          // build a simple object object with cm of islandora:dtu_dc_slide_cmodel and isMemberOf $parent_foxml->pid
          $label = $parent_item->objectProfile->objLabel . " (Slides)";
          $pid = $parent_item->objectProfile->pid . "_slides";
          $content_model_pid = 'islandora:dtu_dc_slide_cmodel';
          $child_item = Fedora_Item::ingest_new_item($pid,$state,$label);
          $child_item->add_relationship($relationship,$collection_pid);
          $child_item->add_relationship('hasModel',$content_model_pid,FEDORA_MODEL_URI);

          // Redundant, but let's build a SWF and TN datastream right now
          $talk_manipulation = new MXDTalkManipulation();
          if( $talk_manipulation->createSWFFromPDF(array(),'OBJSWF',$filename,'swf') ) {
            $swffilename = $_SESSION['fedora_ingest_files']['OBJSWF'];
            unset($_SESSION['fedora_ingest_files']['OBJSWF']);
            $child_item->add_datastream_from_file($swffilename,'OBJSWF');
          }
          if(file_exists($swffilename)) file_delete($swffilename);
          
          if( $talk_manipulation->createThumbnailFromPDF(array('width'=>120,'height'=>128),'TN',$filename,'jpg') ) {
            $tnfilename = $_SESSION['fedora_ingest_files']['TN'];
            unset($_SESSION['fedora_ingest_files']['TN']);
            $child_item->add_datastream_from_file($tnfilename,'TN');
          }
          if(file_exists($tnfilename)) file_delete($tnfilename);

          if( $child_item->add_datastream_from_file($filename,'OBJ') ) {
            drupal_set_message('Item <a href="'.$base_url.'/fedora/repository/">'.$pid.'</a> created successfully');
          }
          if(file_exists($filename)) file_delete($filename);
          break;
          
        case 'VIDEO':
          
          $label = $parent_item->objectProfile->objLabel . " (Video)";
          $pid = $parent_item->objectProfile->pid . "_video";
          $content_model_pid = 'islandora:dtu_dc_video_cmodel';
          $child_item = Fedora_Item::ingest_new_item($pid,$state,$label);
          $child_item->add_relationship($relationship,$collection_pid);
          $child_item->add_relationship('hasModel',$content_model_pid,FEDORA_MODEL_URI);
          
          $child_item->add_datastream_from_url($base_url.'/'.$path.'/images/video.png','TN');
          
          if( $child_item->add_datastream_from_file($filename,'OBJ') ) {
            drupal_set_message('Item <a href="'.$base_url.'/fedora/repository/">'.$pid.'</a> created successfully');
          }
          if(file_exists($filename)) file_delete($filename);
          break;
      }
    }
  }
  return;
  }
  
}

function replace_unicode_escape_sequence($match) {
  return mb_convert_encoding(pack('H*', $match[1]), 'UTF-8', 'UCS-2BE');
}

function url_exists($url) {
  // Version 4.x supported
  $handle   = curl_init($url);
  if (false === $handle)
  {
    return false;
  }
  curl_setopt($handle, CURLOPT_HEADER, false);
  curl_setopt($handle, CURLOPT_FAILONERROR, true);  // this works
  curl_setopt($handle, CURLOPT_HTTPHEADER, Array("User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.15) Gecko/20080623 Firefox/2.0.0.15") ); // request as if Firefox    
  curl_setopt($handle, CURLOPT_NOBODY, true);
  curl_setopt($handle, CURLOPT_RETURNTRANSFER, false);
  $connectable = curl_exec($handle);
  curl_close($handle);   
  return $connectable;
}







