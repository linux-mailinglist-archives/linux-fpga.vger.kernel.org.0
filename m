Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00ECE6B8E
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Oct 2019 04:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfJ1Duy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 27 Oct 2019 23:50:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:60684 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfJ1Duy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 27 Oct 2019 23:50:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 20:50:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="350582691"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2019 20:50:50 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
        atull@kernel.org, gregkh@linuxfoundation.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v5 0/2] add performance reporting support to FPGA DFL drivers
Date:   Mon, 28 Oct 2019 11:31:26 +0800
Message-Id: <1572233488-26533-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz and all,

This patchset adds performance reporting support for FPGA DFL drivers. It
introduces one pmu to expose userspace interfaces via standard perf API.
User could use standard perf tool to access perf events exposed via pmu.

This patchset is generated based on fpga/for-next branch.

Main changes from v4:
 - rebase and clean up.
 - update Kconfig for PERF_EVENTS dependency.

Main changes from v3:
 - add more descriptions in doc, including how to use perf tool for these
   hardware counters. (patch #1)
 - use standard perf API instead of sysfs entries. (patch #2)

Wu Hao (1):
  fpga: dfl: fme: add performance reporting support

Xu Yilun (1):
  Documentation: fpga: dfl: add description for performance reporting
    support

 Documentation/fpga/dfl.rst  |  83 +++++
 drivers/fpga/Kconfig        |   2 +-
 drivers/fpga/Makefile       |   1 +
 drivers/fpga/dfl-fme-main.c |   4 +
 drivers/fpga/dfl-fme-perf.c | 869 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl-fme.h      |   2 +
 drivers/fpga/dfl.h          |   2 +
 7 files changed, 962 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/dfl-fme-perf.c

-- 
1.8.3.1

