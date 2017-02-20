import autosize from 'autosize';

let Messages = {
    init(socket) {
        socket.connect();
        this.onReady(socket);
    },

    onReady(socket) {
        let msgInput = document.getElementById("msg-input");
        let msgContainer = document.getElementById("msg-container");
        let msgInputJq = $('#msg-input');

        let messagesChannel = socket.channel('room:1');

        autosize(msgInputJq);

        msgInputJq.keypress(function(e) {
            if(e.which == 13 && !e.shiftKey) {
                Messages.postMessage(msgInput, msgInputJq, messagesChannel);
                e.preventDefault();
            }
        });

        messagesChannel.on("new_message", (resp) => {
            this.addMessage(msgContainer, resp);
        });

        messagesChannel.join()
            .receive("ok", resp => {
                console.log("joined channel", resp);
            })
            .receive("error", reason => {
                console.log("failed to join channel", reason);
            });

    },

    esc(str) {
        let div = document.createElement('div');
        div.appendChild(document.createTextNode(str));
        return div.innerHTML;
    },

    addMessage(msgContainer, {body, user}) {
        let template = document.createElement('div');
        template.innerHTML = `
            ${this.esc(body)}
        `;
        msgContainer.appendChild(template);
    },

    setFocus(msgInput) {
        msgInput.focus();
    },

    postMessage(msgInput, msgInputJq, messagesChannel) {
        let payload = {body: msgInput.value};
        messagesChannel.push("new_message", payload).receive("error", reason => {console.log(reason)});
        this.afterMessageCleanup(msgInput, msgInputJq);
    },

    afterMessageCleanup(msgInput, msgInputJq) {
        msgInput.value = "";
        this.setFocus(msgInput);
        autosize.update(msgInputJq);
    }
};
export default Messages;
