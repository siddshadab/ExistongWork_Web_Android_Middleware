import { TestBed } from '@angular/core/testing';

import { AuthorizationCheckService } from './authorization-check.service';

describe('AuthorizationCheckService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: AuthorizationCheckService = TestBed.get(AuthorizationCheckService);
    expect(service).toBeTruthy();
  });
});
