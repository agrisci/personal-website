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
            <p className="py-7">
              Provident cupiditate voluptatem et in. Quaerat fugiat ut assumenda
              excepturi exercitationem quasi. In deleniti eaque aut repudiandae
              et a id nisi.
            </p>
          </div>
        </div>
      </div>
    </>
  );
};

export default About;
