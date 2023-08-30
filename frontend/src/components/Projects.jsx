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
              <div className="badge badge-primary">Bash</div>
              <div className="badge badge-accent">React</div>
            </div>
            <p>
              Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ab
              voluptatem facere quaerat ipsa aspernatur consectetur non
              eligendi. Eaque, voluptate blanditiis ipsum eos accusamus magni
              harum optio, qui deserunt, sunt omnis?
            </p>
            <div className="card-actions justify-end">
              <button className="btn btn-primary mt-10">
                Visit Repository
              </button>
            </div>
          </div>
        </div>
        <div className="card lg:card-side bg-secondary-content shadow-xl">
          <figure className="lg:order-last">
            <img
              src="https://daisyui.com/images/stock/photo-1494232410401-ad00d5433cfa.jpg"
              alt="Album"
            />
          </figure>
          <div className="card-body">
            <h2 className="card-title mb-3">Heraklion Waterstatus</h2>
            <div className="flex flex-wrap gap-2 mb-3">
              <div className="badge badge-primary">AWS</div>
              <div className="badge badge-secondary">Terraform</div>
              <div className="badge badge-accent">Jenkins</div>
              <div className="badge badge-primary">Docker</div>
              <div className="badge badge-accent">React</div>
            </div>
            <p>
              Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ab
              voluptatem facere quaerat ipsa aspernatur consectetur non
              eligendi. Eaque, voluptate blanditiis ipsum eos accusamus magni
              harum optio, qui deserunt, sunt omnis?
            </p>
            <div className="card-actions justify-end lg:justify-start">
              <button className="btn btn-primary mt-10">
                Visit Repository
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Projects;
