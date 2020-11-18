Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29DC2B8446
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 20:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKRTAg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 14:00:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:61024 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgKRTAg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 14:00:36 -0500
IronPort-SDR: AXDOC3bcNVh8Ma4X1prYkxWrS1Pu6ht2+1KI+E6mEjn1Bp2RCdc3qEQlcGBjLcGmHLxKzmGE5W
 AfAvdYI0qvhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167658894"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="167658894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 11:00:35 -0800
IronPort-SDR: FEv+/kqHqNMAyftMD2r+WyrZLv0c6fyI7TslEsMU+4BhYnDCMHJtkI8bxBsSOELJD72/XinFBs
 Xws55Cb1hjlw==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="544665312"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 11:00:34 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 0/2] fpga: dfl: optional VSEC for start of dfl
Date:   Wed, 18 Nov 2020 11:01:49 -0800
Message-Id: <20201118190151.365564-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

The start of a Device Feature List (DFL) is currently assumed to be at
Bar0/Offset 0 on the PCIe bus by drivers/fpga/dfl-pci.c.  This patchset
adds support for the start one or more DFLs to be specified in a
Vendor-Specific Capability (VSEC) structure in PCIe config space.  If no
such VSEC structure exists, then the start is assumed to be
Bar0/Offset 0 for backward compatibility.

Matthew Gerlach (2):
  fpga: dfl: refactor cci_enumerate_feature_devs()
  fpga: dfl: look for vendor specific capability

 Documentation/fpga/dfl.rst |  13 +++
 drivers/fpga/dfl-pci.c     | 163 +++++++++++++++++++++++++++++--------
 2 files changed, 141 insertions(+), 35 deletions(-)

-- 
2.25.2

