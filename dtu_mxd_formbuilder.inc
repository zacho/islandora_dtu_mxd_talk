<?php

/**
 * @file 
 * MXD Talk form builder classes
 */
module_load_include('inc', 'fedora_repository', 'plugins/FormBuilder');

/**
 * TalkFormBuilder class
 * Implements methods from content model ingest form xml 
 * builds a dc metadata form
 */
class TalkFormBuilder extends FormBuilder {

  /**
   * Constructor
   */
  function TalkFormBuilder() {
    module_load_include('inc', 'Fedora_Repository', 'plugins/FormBuilder');
  }

  /**
   * Override Create Fedora Data Stream
   * @global type $base_url
   * @param type $form_values
   * @param type $dom
   * @param type $rootElement 
   */
  function createFedoraDataStreams($form_values, &$dom, &$rootElement) {
    module_load_include('inc', 'fedora_repository', 'MimeClass');
    global $base_url;
    $mimetype = new MimeClass();
    $server = NULL;
    $file = $form_values['ingest-file-location'];

    if (!empty($file)) {
      $dformat = $mimetype->getType($file);

      $parts = explode('/', $file);
      foreach ($parts as $n => $part) {
        $parts[$n] = rawurlencode($part);
      }
      $path = implode('/', $parts);
      $fileUrl = $base_url . '/' . $path;

      $beginIndex = strrpos($fileUrl, '/');
      $dtitle = substr($fileUrl, $beginIndex + 1);
      $dtitle = urldecode($dtitle);
      $ds1 = $dom->createElement("foxml:datastream");
      $ds1->setAttribute("ID", "OBJ");
      $ds1->setAttribute("STATE", "A");
      $ds1->setAttribute("CONTROL_GROUP", "M");
      $ds1v = $dom->createElement("foxml:datastreamVersion");
      $rootElement->appendChild($ds1);

      $ds1v->setAttribute("ID", "OBJ.0");
      $ds1v->setAttribute("MIMETYPE", "$dformat");
      $ds1v->setAttribute("LABEL", "$dtitle");
      $ds1content = $dom->createElement('foxml:contentLocation');
      $ds1content->setAttribute("REF", "$fileUrl");
      $ds1content->setAttribute("TYPE", "URL");
      $ds1->appendChild($ds1v);
      $ds1v->appendChild($ds1content);
    }
    if (!empty($_SESSION['fedora_ingest_files'])) {

      foreach ($_SESSION['fedora_ingest_files'] as $dsid => $createdFile) {

        if (!empty($file)) {
          $found = strstr($createdFile, $file);
          if ($found !== FALSE) {
            $createdFile = $found;
          }
        }

        $dformat = $mimetype->getType($createdFile);
        $parts = explode('/', $createdFile);
        foreach ($parts as $n => $part) {
          $parts[$n] = rawurlencode($part);
        }
        $path = implode('/', $parts);
        $fileUrl = $base_url . '/' . $path;

        $beginIndex = strrpos($fileUrl, '/');
        $dtitle = substr($fileUrl, $beginIndex + 1);
        $dtitle = urldecode($dtitle);
        $dtitle = $dtitle;
        $ds1 = $dom->createElement("foxml:datastream");
        $ds1->setAttribute("ID", "$dsid");
        $ds1->setAttribute("STATE", "A");
        $ds1->setAttribute("CONTROL_GROUP", "M");
        $ds1v = $dom->createElement("foxml:datastreamVersion");
        $ds1v->setAttribute("ID", "$dsid.0");
        $ds1v->setAttribute("MIMETYPE", "$dformat");
        $ds1v->setAttribute("LABEL", "$dtitle");
        $ds1content = $dom->createElement('foxml:contentLocation');
        $ds1content->setAttribute("REF", "$fileUrl");
        $ds1content->setAttribute("TYPE", "URL");
        $ds1->appendChild($ds1v);
        $ds1v->appendChild($ds1content);
        $rootElement->appendChild($ds1);
      }
    }
  }
}

?>
