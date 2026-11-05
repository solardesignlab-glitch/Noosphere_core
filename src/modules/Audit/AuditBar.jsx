import React from 'react';

const AuditBar = () => {
  const report = {
    registryModules: 1,
    diskModules: 1,
    orphans: 0,
    missingInRegistry: 0,
  };

  return (
    <div className="audit-bar" style={{
      display: 'flex',
      gap: 'var(--space-1)',
      padding: 'var(--space-1)',
      background: 'var(--color-bg-base)',
      borderBottom: '1px solid var(--color-border-base)',
      alignItems: 'center',
    }}>
      <div style={{ display: 'flex', flexDirection: 'column' }}>
        <span style={{ fontSize: '0.875rem', color: '#666' }}>Registry</span>
        <strong style={{ fontWeight: 600 }}>{report.registryModules}</strong>
      </div>
      <div style={{ display: 'flex', flexDirection: 'column' }}>
        <span style={{ fontSize: '0.875rem', color: '#666' }}>Disk</span>
        <strong style={{ fontWeight: 600 }}>{report.diskModules}</strong>
      </div>
      <div style={{ display: 'flex', flexDirection: 'column' }}>
        <span style={{ fontSize: '0.875rem', color: '#666' }}>Orphans</span>
        <strong style={{ color: report.orphans > 0 ? '#dc2626' : '#1a1a1a', fontWeight: 600 }}>
          {report.orphans}
        </strong>
      </div>
      <div style={{ display: 'flex', flexDirection: 'column' }}>
        <span style={{ fontSize: '0.875rem', color: '#666' }}>Missing</span>
        <strong style={{ fontWeight: 600 }}>{report.missingInRegistry}</strong>
      </div>
    </div>
  );
};

export default AuditBar;
