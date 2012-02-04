jQuery ->
  doc_width = jQuery(document).width() * 1.05
  left_pos = -20
  while (left_pos + 300) < doc_width
    left_pos += 150 * Math.random() + 100
    jQuery(".hill").first().clone().css("left", left_pos).appendTo ".non-shadow-hills"
  jQuery(".non-shadow-hills>.hill").clone().appendTo ".shadow-hills"
  jQuery(".search-button").mouseup ->
    jQuery(this).css("background-color", "#222").css("border-color", "#fff").css("outline-color", "#222").css "color", "#fff"

  jQuery(".search-button").mousedown ->
    jQuery(this).css("background-color", "#fff").css("border-color", "#222").css("outline-color", "#fff").css "color", "#222"