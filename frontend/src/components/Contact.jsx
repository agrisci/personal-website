import { useRef } from "react";
import emailjs from "@emailjs/browser";

const Contact = () => {
  const form = useRef();

  const sendEmail = (e) => {
    e.preventDefault();

    emailjs
      .sendForm(
        "service_5o8gfae",
        "template_mkjwktn",
        form.current,
        "XkOkYqkX-uYjgLECd"
      )
      .then(
        (result) => {
          console.log(result.text);
          form.current.reset();
        },
        (error) => {
          console.log(error.text);
          form.current.reset();
        }
      );
  };
  return (
    <>
      <div className="px-4 lg:px-24 xl:px-44 py-10" name="Contact">
        <h1 className="text-3xl text-center font-bold pb-10">Contact</h1>
        <p className="text-center mb-6 p-6">
          Feel free to contact me using this form! You can also message me
          on&nbsp;
          <a
            rel="noreferrer noopener"
            target="_blank"
            href="https://www.linkedin.com/in/apostolos-tanopoulos"
            className="text-info"
          >
            LinkedIn.
          </a>
        </p>
        <form ref={form} onSubmit={sendEmail}>
          <div className="flex flex-col gap-4 items-center">
            <input
              name="name"
              type="text"
              placeholder="Name"
              className="input input-bordered input-secondary w-full max-w-xs"
            />
            <input
              name="reply_to"
              type="text"
              placeholder="Email"
              className="input input-bordered input-secondary w-full max-w-xs"
            />
            <textarea
              name="message"
              className="textarea textarea-secondary w-full max-w-xs h-40"
              placeholder="Message"
            ></textarea>
            <button className="btn btn-primary mt-3" type="submit" value="Send">
              Submit
            </button>
          </div>
        </form>
      </div>
    </>
  );
};

export default Contact;
