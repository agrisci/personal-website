const Projects = () => {
  return (
    <>
      <div className="px-4 lg:px-24 xl:px-44 py-10" name="Projects">
        <h1 className="text-3xl text-center font-bold pb-10">Projects</h1>
        <div className="card lg:card-side bg-secondary-content shadow-xl mb-10">
          <figure>
            <img
              src="https://daisyui.com/images/stock/photo-1494232410401-ad00d5433cfa.jpg"
              alt="Album"
            />
          </figure>
          <div className="card-body">
            <h2 className="card-title mb-3">Personal Website/Portfolio</h2>
            <div className="flex flex-wrap gap-2 mb-3">
              <div className="badge badge-primary">AWS</div>
              <div className="badge badge-secondary">Terraform</div>
              <div className="badge badge-accent">Jenkins</div>
              <div className="badge badge-primary">Docker</div>
              <div className="badge badge-secondary">Bash</div>
              <div className="badge badge-accent">ReactJS</div>
            </div>
            <p>
              My current personal/portfolio website hosted in AWS using
              Terraform for IAC and Jenkins for CI/CD.
            </p>
            <div className="card-actions justify-end">
              <a
                className="btn btn-primary mt-10"
                target="_blank"
                rel="noopener noreferrer"
                href="https://github.com/agrisci/personal-website"
              >
                Visit Repository
              </a>
            </div>
          </div>
        </div>
        <div className="card lg:card-side bg-secondary-content shadow-xl">
          <figure className="lg:order-last">
            <img
              className="object-cover w-1/3 cursor-pointer mr-2"
              src="https://raw.githubusercontent.com/agrisci/heraklion-waterstatus/master/project-assets/apk-img/1.png"
              alt="Album"
            />
            <img
              className="object-cover w-1/3 cursor-pointer ml-2"
              src="https://raw.githubusercontent.com/agrisci/heraklion-waterstatus/master/project-assets/apk-img/2.png"
              alt="Album"
            />
          </figure>
          <div className="card-body">
            <h2 className="card-title mb-3">Heraklion Waterstatus</h2>
            <div className="flex flex-wrap gap-2 mb-3">
              <div className="badge badge-primary">Google Play Console</div>
              <div className="badge badge-secondary">NodeJS</div>
              <div className="badge badge-accent">ExpressJS</div>
              <div className="badge badge-primary">MongoDB</div>
              <div className="badge badge-secondary">Ionic</div>
              <div className="badge badge-accent">Capacitor</div>
              <div className="badge badge-primary">ReactJS</div>
            </div>
            <p className="!flex-grow-0">
              A fullstack Android application allowing users to view the current
              water supply status and history of all supported areas by DEYAH
              for the city of Heraklion Crete Greece.
            </p>
            <p>
              Provides the ability based on users current GPS location or
              manually to subscribe to areas and receive Push Notifications on
              supply status change.
            </p>
            <div className="card-actions justify-end lg:justify-start">
              <a
                className="btn btn-primary mt-10"
                target="_blank"
                rel="noopener noreferrer"
                href="https://github.com/agrisci/heraklion-waterstatus"
              >
                Visit Repository
              </a>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Projects;
