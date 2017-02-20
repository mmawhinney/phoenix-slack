let Messages = {
    init() {
        this.onReady();
    },

    onReady() {
        let postButton = document.getElementById("post-btn");
        let msgInput = document.getElementById("msg-input");
        let msgContainer = document.getElementById("msg-container");

        this.setFocus(msgInput);

        postButton.addEventListener("click", e => {
            this.addMessage(msgContainer, msgInput.value);
            msgInput.value = "";
            this.setFocus(msgInput);
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
