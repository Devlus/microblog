// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

rivets.formatters.log = function (model) {
    console.log(model);
};

// let $ = require("jquery");
$(function () {
    let likers = {};
    const likes = $('.like');
    if (!likes.length) {
        return;
    }
    function updateLike(postId, el) {
        $.getJSON("/api/like/" + postId, (data) => {
            var postLikers = data.data;
            postLikers.count = postLikers.length;
            if (likers[postId]) {
                debugger;
                likers[postId].count = postLikers.count;
                while(likers[postId].length){
                    likers[postId].pop();
                }
                likers[postId].push(...data.data)
                console.log(likers[postId])
            } else {
                likers[postId] = postLikers;
                rivets.bind(el, { likers: postLikers });
            }
        });
    }
    function updateLikes() {
        likes.each(function () {
            const postId = $(this).attr("data-post")
            updateLike(postId, $(this));
        });
    }
    likes.click(function () {
        const postId = $(this).attr("data-post");
        const userId = $(this).attr("data-user");
        const csrf = $(this).attr("data-csrf");
        $.ajax({
            url: "/api/like",
            type: "POST",
            dataType: "json",
            headers: { "X-CSRF-Token": csrf },
            data: {
                like: { post_id: postId, actor_id: userId }
            }, success: () => updateLike(postId, $(this))
        });
    });
    updateLikes();
})