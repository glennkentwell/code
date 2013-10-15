<?
$ser = 'O:8:"Template":19:{s:6:"_model";s:7:"Product";s:7:"_layout";s:12:"default/list";s:9:"_template";s:12:"default/list";s:11:"_linkdomain";s:1:"1";s:9:"_linkpage";s:7:"product";s:12:"_templatevar";a:1:{s:13:"show_order_by";s:1:"0";}s:8:"_orderby";s:13:"categoryorder";s:9:"_category";s:1:"0";s:6:"_limit";s:0:"";s:11:"_pagination";s:0:"";s:17:"_pagination_class";s:0:"";s:20:"_pagination_ul_class";s:0:"";s:21:"_pagination_prevlabel";s:0:"";s:21:"_pagination_nextlabel";s:0:"";s:26:"_pagination_firstpagelabel";s:0:"";s:25:"_pagination_lastpagelabel";s:0:"";s:22:"_pagination_maxbuttons";s:0:"";s:18:"_pagination_header";s:0:"";s:18:"_pagination_footer";s:0:"";}';

$obj = unserialize($ser);

print_r($obj);

echo $obj->toString();
