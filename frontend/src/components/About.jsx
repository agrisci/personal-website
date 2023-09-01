const About = () => {
  return (
    <>
      <div
        className="hero min-h-screen bg-secondary-content px-4 lg:px-24 xl:px-44"
        name="About"
      >
        <div className="hero-content flex-col lg:flex-row">
          <img
            src="https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"
            className="sm:w-5/6 md:w-4/6 lg:w-2/6 rounded-lg shadow-2xl lg:order-last"
          />
          <div className="py-6 lg:py-0">
            <h1 className="text-5xl font-bold">Hi, I'm Apostolis Tanopoulos</h1>
            <p className="pt-7">
              I'm a DevOps enthusiast with a strong foundation in Web
              Development and Linux System Administration. Currently, I'm
              employed as a Web Developer/DevOps Engineer, where I apply my
              expertise in technologies like{" "}
              <span className="font-bold">
                AWS, Terraform, Kubernetes, Docker, Jenkins, GitLab, AWS and
                more
              </span>{" "}
              to streamline and enhance development and deployment processes.
            </p>
            <h1 className="text-2xl font-bold pt-5 pb-2">Why DevOps?</h1>
            <p>
              I'm passionate about DevOps because it's the bridge that
              transforms code into powerful, automated solutions. It's not
              merely a career choice; it's a commitment to efficient software
              development, deployment, and continuous innovation. I thrive on
              curiosity and the desire to understand how things work, making
              every project an opportunity to learn and grow.
            </p>
            <h1 className="text-2xl font-bold pt-5 pb-2">
              My Playground: Homelab and Work
            </h1>
            <p>
              At my HomeLab and my current workplace, I continually explore and
              implement cutting-edge technologies, ensuring that I stay at the
              forefront of the tech landscape. Whether it's experimenting with
              new tools or optimizing existing processes, I'm fueled by my
              curiosity and eagerness to acquire knowledge.
            </p>
            <h1 className="text-2xl font-bold pt-5 pb-2">Why Choose Me?</h1>
            <p>
              My background in Web Development ensures a keen eye for
              application delivery, while my Linux expertise guarantees robust
              infrastructure and security. I'm here to optimize your development
              and operations, driving your DevOps journey to success. Welcome to
              my portfolio, where expertise meets innovation, and DevOps thrive.
            </p>
          </div>
        </div>
      </div>
    </>
  );
};

export default About;
