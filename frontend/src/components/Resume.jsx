import ModalImage from "react-modal-image";

const Resume = () => {
  return (
    <div
      className="bg-secondary-content px-4 lg:px-24 xl:px-44 py-10"
      name="Resume"
    >
      <h1 className="text-3xl text-center font-bold pb-10">Resume</h1>
      <div className="flex justify-center">
        <ModalImage
          small={"/resume-small.png"}
          medium={"/resume-medium.png"}
          large={"/resume.png"}
          hideDownload={true}
          alt="Resume"
        />
      </div>
      <div className="text-center mt-10">
        <a className="btn btn-primary" href="/resume.pdf" download>
          Download as pdf
        </a>
      </div>
    </div>
  );
};

export default Resume;
