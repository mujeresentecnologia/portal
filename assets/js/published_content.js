function showMoreContent(maxPosts){
    var hiddenPosts = document.getElementsByClassName('met_hidden');
    
    var totalHiddenPosts = hiddenPosts.length;
    var totalPostsToShow = getHiddenPostsLeft(hiddenPosts.length, maxPosts);

    for (var i = 0; i < totalPostsToShow; i++) {
        hiddenPosts[0].removeAttribute('class');
		}
		
		var postsLeft = totalHiddenPosts - totalPostsToShow;
    displayButton(postsLeft, maxPosts);
}

function getHiddenPostsLeft(hiddenPostsSize, maxPosts) {
    var postsLeft = 0;
    if (hiddenPostsSize < maxPosts) {
        return postsLeft = hiddenPostsSize;
    } else {
        return postsLeft = maxPosts;
    }
}

function displayButton(postsLeft, maxPosts) {
		var showMorePostsButton = document.getElementById('met_show_posts');
		var empty = 0;

    if (postsLeft == empty) {
        showMorePostsButton.style.display = 'none';
    }
}