<?php
 /**
  * This template is intended to be loaded in a colorbox/lightbox/etc. iframe
  * dynamically from a drupal page, and hence lacks the typical drupal page stuff.
  * Instead, this page attempts to insert a PDF object into the entirety of the page
  * for browsers which can handle PDFs natively, otherwise it tries to use FlexPaper
  * to display an SWF version of the PDF doc, also filling the entire page.
  *
  * I'm not great with theming so I've "passed" two variables here using the session 
  * variable.  It works. 
  *
  * Made by Zac Howarth, 2011-12-27
  */
  
  $pdfurl = $_SESSION['dtu-paper-pdf-url'];
  $swfurl = $_SESSION['dtu-paper-swf-url'];
  unset($_SESSION['dtu-paper-pdf-url']);
  unset($_SESSION['dtu-paper-swf-url']);
  
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">  
  <head> 
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
      <title>FlexPaper</title>         
      <style type="text/css" media="screen"> 
        html, body  { height:100%; }
        body { margin:0; padding:0; overflow:auto; }   
        #flashContent { display:none; }
      </style> 

<?php if($swfurl) : ?>
  <script type="text/javascript" src="/sites/all/libraries/flexpaper/js/flexpaper_flash.js"></script>
<?php endif; ?>
<?php if($pdfurl) : ?>
  <script type="text/javascript" src="/sites/all/libraries/PDFObject/pdfobject.js"></script>
  <script type="text/javascript">
    window.onload = function (){
      var myPDF = new PDFObject({ 
        url: '<?php echo $pdfurl; ?>',
        pdfOpenParams: { view: 'FitH', toolbar: '1' }
      }).embed('viewerPlaceHolder'); 
    };
  </script>
<?php endif; ?>

  </head> 
  <body> 
    <div style="width:100%;height:100%;margin:auto" id="viewerPlaceHolder"><?php echo $content; ?>

<?php if($swfurl) : ?>
      <script type="text/javascript"> 
         var fp = new FlexPaperViewer( 
              'FlexPaperViewer',
              'viewerPlaceHolder', { config : {
                SwfFile : escape('<?php echo $swfurl; ?>'),
                Scale : 0.6, 
                ZoomTransition : 'easeOut',
                ZoomTime : 0.5,
                ZoomInterval : 0.2,                                                                                                                
                FitPageOnLoad : false,
                FitWidthOnLoad : true,
                FullScreenAsMaxWindow : false,
                ProgressiveLoading : false,
                MinZoomSize : 0.2,
                MaxZoomSize : 5,
                SearchMatchAll : false,
                InitViewMode : 'Portrait',
                PrintPaperAsBitmap : false,
                
                ViewModeToolsVisible : true,
                ZoomToolsVisible : false,
                NavToolsVisible : true,
                CursorToolsVisible : true,
                SearchToolsVisible : true,
               
                localeChain: 'en_US'
              }});
      </script>
      
<?php endif; ?>

    </div>
  </body> 
</html>

