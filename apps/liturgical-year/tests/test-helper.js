import Application from 'liturgical-year/app';
import config from 'liturgical-year/config/environment';
import * as QUnit from 'qunit';
import { setup } from 'qunit-dom';

import { setApplication } from '@ember/test-helpers';

import start from 'ember-exam/test-support/start';

setApplication(Application.create(config.APP));

setup(QUnit.assert);

// Options passed to `start` will be passed-through to ember-qunit or ember-mocha
start({ setupTestIsolationValidation: true });
