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

import socket from "./socket"

rivets.formatters.log = function (model) {
    console.log(model);
};

function handleLikes() {
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
                while (likers[postId].length) {
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
        if (!userId) {
            return;
        }
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
}

function handleUpdateChannel() {
    let model = { posts: [] };
    let form = $("#post_form");
    let channel = null;
    $("#submit-post").click(function (event) {
        //Taken from https://stackoverflow.com/a/11855073 in part
        event.preventDefault();
        $.ajax({
            type: form.attr('method'),
            url: form.attr('action'),
            data: form.serialize(),
            success: function (data) {
                $(form).find('textarea').val("");
                channel.push("post_created", {});
            }
        });
    });
    function getLikesForPosts() {
        function likeWasClicked(el, model) {
            const postId = $(this).attr("data-post");
            const userId = $(this).attr("data-user");
            if (!userId) {
                return;
            }
            const csrf = $(this).attr("data-csrf");
            $.ajax({
                url: "/api/like",
                type: "POST",
                dataType: "json",
                headers: { "X-CSRF-Token": csrf },
                data: {
                    like: { post_id: postId, actor_id: userId }
                }, success: () => {
                    var post = model.posts.filter((item) => item.id == postId )[0];
                    updateLike(postId, post);
                }
            });
        }
        function updateLike(postId, el) {
            el.likers = {
                clicked: likeWasClicked
            };
            $.getJSON("/api/like/" + postId, (data) => {
                el.likers.list = data.data;
                el.likers.count = data.data.length;
                // postLikers.count = postLikers.length;
                // if (likers[postId]) {
                //     debugger;
                //     likers[postId].count = postLikers.count;
                //     while (likers[postId].length) {
                //         likers[postId].pop();
                //     }
                //     likers[postId].push(...data.data)
                //     console.log(likers[postId])
                // } else {
                //     likers[postId] = postLikers;
                //     rivets.bind(el, { likers: postLikers });
                // }
            });
        }
        function updateLikes() {
            debugger;
            model.posts.forEach(function (e) {
                const postId = e.id
                updateLike(postId, e);
            });
        }
        updateLikes();
    }


    rivets.bind($("#post_section"), model);
    function connected(posts) {
        console.log("Connected");
        channel.push("pull", {});
    }
    function gotPosts(response) {
        console.log(response);
        model.posts = response.posts;
        getLikesForPosts();
    }
    channel = socket.channel("updates:" + window.currentUserPageId, {})
    channel.join().receive("ok", connected)
    channel.on("posts", gotPosts)
}



// let $ = require("jquery");
$(function () {
    handleUpdateChannel();
    handleLikes();
})