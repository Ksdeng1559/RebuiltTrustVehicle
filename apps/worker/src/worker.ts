type MatchJob = {
  buyerProfileId: string;
  listingId: string;
};

function scoreMatch(job: MatchJob) {
  // Placeholder for explainable matching rules.
  // Phase 1 scoring should remain deterministic and auditable.
  return {
    ...job,
    score: 0,
    reasons: [] as string[],
    evaluatedAt: new Date().toISOString(),
  };
}

console.log('RebuiltTrustVehicle worker ready');
console.log(scoreMatch({ buyerProfileId: 'example-buyer', listingId: 'example-listing' }));
