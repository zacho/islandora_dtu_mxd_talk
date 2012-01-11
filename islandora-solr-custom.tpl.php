<?php

/**
 * @file islandora-solr-custom.tpl.php
 * Islandora solr search results template
 *
 * Variables available:
 * - $variables: all array elements of $variables can be used as a variable. e.g. $base_url equals $variables['base_url']
 * - $base_url: The base url of the current website. eg: http://example.com .
 * - $user: The user object.
 *
 * - $style: the style of the display ('div' or 'table'). Set in admin page by default. Overridden by the query value: ?display=foo
 * - $results: the array containing the solr search results
 * - $table_rendered: If the display style is set to 'table', this will contain the rendered table.
 *    For theme overriding, see: theme_islandora_solr_custom_table() 
 * - $switch_rendered: The rendered switch to toggle between display styles
 *    For theme overriding, see: theme_islandora_solr_custom_switch() 
 *
 */
?>

<?php print $switch_rendered; ?>

<?php if ($style == 'div'): ?>

<ol class="islandora_solr_results" start="<?php print $record_start; ?>">
<?php if ($results == ''): print '<p>' . t('Your search yielded no results') . '</p>'; ?>
<?php else: ?>
<?php foreach ($results as $id => $result): ?>
  <li class="islandora_solr_result">
    <!-- <div class="solr-field <?php print $result['dsm.OBJ_EXIFTOOL']['class']; ?>">
      <div class="label"><label><?php print t($result['dsm.OBJ_EXIFTOOL']['label']); ?></label></div>
      <div class="value"><?php print $result['dsm.OBJ_EXIFTOOL']['value']; ?></div>
    </div> -->
    <!-- <div class="solr-field <?php print $result['dc.language']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.language']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.language']['value']; ?></div>
    </div> -->
    <div class="solr-field <?php print $result['dsm.OBJSWF']['class']; ?>">
      <div class="label"><label><?php print t($result['dsm.OBJSWF']['label']); ?></label></div>
      <div class="value"><?php print $result['dsm.OBJSWF']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['PID']['class']; ?>">
      <div class="label"><label><?php print t($result['PID']['label']); ?></label></div>
      <div class="value"><?php print $result['PID']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.publisher']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.publisher']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.publisher']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dsm.COLLECTION_POLICY']['class']; ?>">
      <div class="label"><label><?php print t($result['dsm.COLLECTION_POLICY']['label']); ?></label></div>
      <div class="value"><?php print $result['dsm.COLLECTION_POLICY']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.contributor']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.contributor']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.contributor']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.rights']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.rights']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.rights']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.subject.facet']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.subject.facet']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.subject.facet']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dsm.TN']['class']; ?>">
      <div class="label"><label><?php print t($result['dsm.TN']['label']); ?></label></div>
      <div class="value"><?php print $result['dsm.TN']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['fgs.label']['class']; ?>">
      <div class="label"><label><?php print t($result['fgs.label']['label']); ?></label></div>
      <div class="value"><?php print $result['fgs.label']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['timestamp']['class']; ?>">
      <div class="label"><label><?php print t($result['timestamp']['label']); ?></label></div>
      <div class="value"><?php print $result['timestamp']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['fgs.lastModifiedDate']['class']; ?>">
      <div class="label"><label><?php print t($result['fgs.lastModifiedDate']['label']); ?></label></div>
      <div class="value"><?php print $result['fgs.lastModifiedDate']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dsm.OBJ']['class']; ?>">
      <div class="label"><label><?php print t($result['dsm.OBJ']['label']); ?></label></div>
      <div class="value"><?php print $result['dsm.OBJ']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.title']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.title']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.title']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.relation']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.relation']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.relation']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.type.facet']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.type.facet']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.type.facet']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.format']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.format']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.format']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.description']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.description']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.description']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dsm.ISLANDORACM']['class']; ?>">
      <div class="label"><label><?php print t($result['dsm.ISLANDORACM']['label']); ?></label></div>
      <div class="value"><?php print $result['dsm.ISLANDORACM']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['fgs.createdDate']['class']; ?>">
      <div class="label"><label><?php print t($result['fgs.createdDate']['label']); ?></label></div>
      <div class="value"><?php print $result['fgs.createdDate']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.creator']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.creator']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.creator']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.subject']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.subject']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.subject']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.date']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.date']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.date']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.source']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.source']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.source']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.source.facet']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.source.facet']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.source.facet']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.identifier']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.identifier']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.identifier']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.type']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.type']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.type']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.audience']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.audience']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.audience']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dsm.PROXY_MP3']['class']; ?>">
      <div class="label"><label><?php print t($result['dsm.PROXY_MP3']['label']); ?></label></div>
      <div class="value"><?php print $result['dsm.PROXY_MP3']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['fgs.state']['class']; ?>">
      <div class="label"><label><?php print t($result['fgs.state']['label']); ?></label></div>
      <div class="value"><?php print $result['fgs.state']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['fgs.ownerId']['class']; ?>">
      <div class="label"><label><?php print t($result['fgs.ownerId']['label']); ?></label></div>
      <div class="value"><?php print $result['fgs.ownerId']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dsm.OBJ.facet']['class']; ?>">
      <div class="label"><label><?php print t($result['dsm.OBJ.facet']['label']); ?></label></div>
      <div class="value"><?php print $result['dsm.OBJ.facet']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.description.facet']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.description.facet']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.description.facet']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.creator.facet']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.creator.facet']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.creator.facet']['value']; ?></div>
    </div>
    <div class="solr-field <?php print $result['dc.coverage']['class']; ?>">
      <div class="label"><label><?php print t($result['dc.coverage']['label']); ?></label></div>
      <div class="value"><?php print $result['dc.coverage']['value']; ?></div>
    </div>
  </li>
<?php endforeach; ?>
<?php endif; ?>
</ol>

<?php elseif ($style == 'table'): ?>

  <table class="sticky-enabled islandora_solr_results">
    <thead>
      <tr>
        <th><!-- jquery open --></th>
        <th>Conference</th>
        <th>Author</th>
        <th>Title</th>
        <th>Video</th>
        <th>Slides</th>
        <th>Paper</th>
      </tr>
    </thead>
    <tbody>
<?php if ($results == ''): print '<tr><td colspan="6">' . t('Your search yielded no results') . '</td></tr>'; ?>
<?php else: ?>
  <?php 
    $count = 0;
    module_load_include('inc', 'fedora_repository', 'api/fedora_item');
    module_load_include('inc', 'fedora_repository', 'ObjectHelper');
    module_load_include('inc', 'islandora_dtu_mxd_talk', 'dtu_mxd_talk');
  ?>
  <?php foreach ($results as $id => $result): ?>
    <?php
      $pid = array_shift($result['PID']['value']);
      $objectHelper = new TalkObjectHelper();
      $item = new Fedora_Item($pid);
      $object_html = $objectHelper->getFormattedDatastreams($item,true);
    ?>
    <tr class="toggle-solr-row <?php print ($count%2 ? 'even' : 'odd' ); print ($count===0 ? ' first' : '') ?>">
      <td class="solr-cell jquery-toggle"><a class="object-link" href="<?php print $base_url; ?>/fedora/repository/<?php print $pid; ?>/-/<?php print $item->objectProfile->objLabel; ?>">+</a></td>
      <td class="solr-cell <?php print $result['dc.source']['class']; ?>"><?php if($result['dc.source']['value']) print array_shift($result['dc.source']['value']); ?></td>
      <td class="solr-cell <?php print $result['dc.creator']['class']; ?>">
        <?php if($result['dc.creator']['value']) print array_shift($result['dc.creator']['value']); ?>
      </td>
      <td class="solr-cell <?php print $result['dc.title']['class']; ?>"><?php if($result['dc.title']['value']) print array_shift($result['dc.title']['value']); ?></td>
      <!-- Call an function which will do a mulgara query, process an XSLT, and return three table cells -->
      <?php print $object_html; ?>
    </tr>
    <tr class="toggleable-solr-row hidden <?php print ($count%2 ? 'even' : 'odd' ); ?>" id="toggleable-solr-row-<?php print ($count+1); ?>">
      <td class="hidden solr-cell"></td>
      <td class="hidden solr-cell <?php print $result['dc.source']['class']; ?>">
        <?php if($result['dc.source']['value']): ?>
          <?php foreach($result['dc.source']['value'] as $key => $value): ?>
            <span class="source"><?php print $value; ?></span>
          <?php endforeach; ?>
        <?php endif; ?>
      </td>
      <td class="hidden solr-cell <?php print $result['dc.creator']['class']; ?>">
        <?php if($result['dc.creator']['value']): ?>
          <?php foreach($result['dc.creator']['value'] as $key => $value): ?>
            <span class="creator"><?php print $value; ?></span>
          <?php endforeach; ?>
        <?php endif; ?>
      </td>
      <td colspan="4" class="hidden solr-cell <?php print $result['dc.description']['class']; ?>">
        <?php if($result['dc.description']['value']): ?>
          <span class="abstract">Abstract:</span>
          <span class="description"><?php print array_shift($result['dc.description']['value']); ?></span>
        <?php endif; ?>
      </td>
    </tr>
  <?php $count++; ?>
  <?php endforeach; ?>
<?php endif; ?>
    </tbody>
  </table>

<pre>
  <?php //print_r($results); ?>
</pre>

  <?php //print $table_rendered; ?>

<?php endif;