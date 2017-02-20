import autosize from 'autosize';

let Messages = {
    init() {
        this.onReady();
    },

    onReady() {
        let postButton = document.getElementById("post-btn");
        let msgInput = document.getElementById("msg-input");
        let msgContainer = document.getElementById("msg-container");
        let msgInputJq = $('#msg-input');
        // this.setFocus(msgInput);

        autosize(msgInputJq);

        msgInputJq.keypress(function(e) {
            if(e.which == 13 && !e.shiftKey) {
                Messages.addMessage(msgContainer, msgInput.value);
                msgInput.value = "";
                Messages.setFocus(msgInput);
                autosize.update(msgInputJq);
                e.preventDefault();
            }
        });

        postButton.addEventListener("click", e => {
            this.addMessage(msgContainer, msgInput.value);
            msgInput.value = "";
            this.setFocus(msgInput);
            autosize.update(msgInputJq);
            autosize.update(msgInputJq);
        })

    },

    esc(str) {
        let div = document.createElement('div');
        div.appendChild(document.createTextNode(str));
        return div.innerHTML;
    },

    addMessage(msgContainer, text) {
        let template = document.createElement('div');
        template.innerHTML = `
            ${this.esc(text)}
        `;
        msgContainer.appendChild(template);
    },

    setFocus(msgInput) {
        msgInput.focus();
    }
};
export default Messages;
