import React from 'react';
import { createRoot } from 'react-dom/client';
import './styles.css';

function App() {
  return (
    <main className="shell">
      <section className="hero">
        <p className="eyebrow">RebuiltTrustVehicle</p>
        <h1>Trusted commerce for rebuilt vehicles.</h1>
        <p className="lede">
          Verified dealer inventory, private buyer demand, financing, warranty,
          vehicle trust records and AI-assisted matching in one transaction network.
        </p>
        <div className="actions">
          <button>Browse rebuilt vehicles</button>
          <button className="secondary">Create a buyer profile</button>
        </div>
      </section>

      <section className="grid" aria-label="Marketplace pillars">
        {[
          ['Authorized Dealers', 'Verified commercial inventory and transaction execution.'],
          ['Private Buyers', 'Structured demand profiles matched to current and incoming vehicles.'],
          ['Vehicle Trust Records', 'VIN-linked evidence, rebuilt disclosure, inspection and repair history.'],
          ['Transaction Protection', 'Financing and warranty workflows integrated into the buying journey.'],
        ].map(([title, copy]) => (
          <article key={title} className="card">
            <h2>{title}</h2>
            <p>{copy}</p>
          </article>
        ))}
      </section>
    </main>
  );
}

createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
