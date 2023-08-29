import { Link } from "react-scroll";

const Navbar = () => {
  return (
    <>
      <div className="navbar sticky bg-neutral top-0 z-50">
        <div className="navbar-start">
          <div className="dropdown">
            <label tabIndex={0} className="btn btn-ghost lg:hidden">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="h-5 w-5"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M4 6h16M4 12h8m-8 6h16"
                />
              </svg>
            </label>
            <ul
              tabIndex={0}
              className="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-52"
            >
              <li className="py-2">
                <Link to="About" spy={true} smooth={true}>
                  About
                </Link>
              </li>
              <li className="py-2">
                <Link to="Projects" spy={true} smooth={true}>
                  Projects
                </Link>
              </li>
              <li className="py-2">
                <Link to="Resume" spy={true} smooth={true}>
                  Resume
                </Link>
              </li>
              <li className="py-2">
                <Link to="Contact" spy={true} smooth={true}>
                  Contact
                </Link>
              </li>
            </ul>
          </div>
          <a className="btn btn-ghost normal-case text-xl" href="/">
            Apostolis Tanopoulos
          </a>
        </div>
        <div className="navbar-end hidden lg:flex">
          <ul className="menu menu-horizontal px-1">
            <li>
              <a>About</a>
            </li>
            <li>
              <a>Projects</a>
            </li>
            <li>
              <a>Resume</a>
            </li>
            <li>
              <a>Contact</a>
            </li>
          </ul>
        </div>
      </div>
    </>
  );
};

export default Navbar;
