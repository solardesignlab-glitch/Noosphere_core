export const ATOM = 16;

export const AXES = {
  X: { name: "geometry", zero: "A", unit: "atom", basePx: ATOM },
  Y: { name: "data", zero: "U1", unit: "registry record" },
  Z: { name: "navigation", zero: "/", unit: "route step" },
};

export function atom(n) {
  if (!Number.isInteger(n) || n < 0) {
    throw new Error(
      `Atom size must be a non-negative integer, received: ${n}`
    );
  }
  return `${n * ATOM}px`;
}

export function makeAddress({ x, y, z, layer = "L1" }) {
  if (!x || !y || !z) {
    throw new Error(
      "Element requires coordinates on X, Y and Z axes"
    );
  }
  return `${z}/${y}/${x}/${layer}`;
}

export function validateElement(element) {
  const errors = [];

  if (!element.id) {
    errors.push("Missing id");
  }

  if (!element.x) {
    errors.push("Missing X coordinate (geometry)");
  }

  if (!element.y) {
    errors.push("Missing Y coordinate (data/registry)");
  }

  if (!element.z) {
    errors.push("Missing Z coordinate (navigation)");
  }

  if (!Number.isInteger(element.sizeAtoms)) {
    errors.push("Size must be an integer number of atoms");
  }

  if (!element.createdAt) {
    errors.push("Missing createdAt");
  }

  if (!element.updatedAt) {
    errors.push("Missing updatedAt");
  }

  return {
    valid: errors.length === 0,
    errors,
  };
}