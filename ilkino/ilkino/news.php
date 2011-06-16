<?php 
header("Content-type: text/xml"); 

require( 'wp-load.php' );
$idprod = 0;  //producer id

echo "<?xml version='1.0' encoding='UTF-8'?>"; 
echo "<articles>";

query_posts('orderby=name&order=asc&cat=17&showposts=50'); 
 while (have_posts()) : the_post(); 
	if ($imgpath = get_post_meta($post->ID, "image", $single = true) != NULL) {
	echo "<article>";
	echo "<articleid>".$idprod."</articleid>";
	echo "<imglink>";
	echo "http://www.ilkino.it/wp-content/themes/kino/thumb.php?src=http://www.ilkino.com/wp-content/uploads/";
	echo "</imglink>";

		$imgpath = get_post_meta($post->ID, "image", $single = true);
		$imgpos = strpos($imgpath, "uploads/")+8;
	    if ($imgpos != false) {
			$imglink = substr($imgpath, $imgpos);
		}
		echo "<img>";
		echo $imglink;
		echo "</img>";

	echo "<title>";
		the_title();
	echo "</title>";
	
	echo "<author>";
		the_author();
	echo "</author>";
	
/*	echo "<text>";
		remove_filter('the_excerpt', 'wpautop');
		the_excerpt();
	echo "</text>";*/
		
	echo "<link>";
		the_permalink();
	echo "</link>";
	echo "</article>";	
}
 endwhile;

	echo '</articles>';
?>

<?php
function catch_that_image() {
  global $post, $posts;
  $first_img = '';
  ob_start();
  ob_end_clean();
  $output = preg_match_all('/<img.+src=[\'"]([^\'"]+)[\'"].*>/i', $post->post_content, $matches);
  $first_img = $matches [1] [0];

  if(empty($first_img)){ //Defines a default image
    $first_img = "/images/default.jpg";
  }
  return $first_img;
}
?>